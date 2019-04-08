//
//  TextSubSearch.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import ReactorKit
import RxDataSources
import RxSwift
import UIKit

class TextSubSearchViewController: UIViewController, SearchOptionProtocol {

    let keywords = ["건축", "도시", "숲"]
    let tickerImageView = UIImageView()
    let titleView = UILabel()
    let searchFieldView = UITextField()
    let doneButton = UIButton(type: .system)
    let searchHandler: ((String) -> Void)!

    let dataSource = RxCollectionViewSectionedAnimatedDataSource<TextSubSection>(
        configureCell: { ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: TextSubCell.swiftIdentifier, for: ip) as? TextSubCell else {
                return UICollectionViewCell()
            }
            cell.configCell(item)
            return cell
        }
    )

    var collectionView: UICollectionView!

    let keywordCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(TextSubCell.self, forCellWithReuseIdentifier: TextSubCell.swiftIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(searchHandler: @escaping (String) -> Void) {
        self.searchHandler = searchHandler
        super.init(nibName: nil, bundle: nil)
        reactor = TextSubSearchReactor(keywords: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tickerImageView.do {
            view.addSubview($0)
            $0.image = Asset.icHome.image
            $0.snp.makeConstraints({ make in
                let width = 20
                make.width.equalTo(width)
                make.height.equalTo(width)
                make.leading.equalToSuperview().offset(20)
                make.top.equalTo(safeAreaTop)
            })
        }
        titleView.do {
            view.addSubview($0)
            $0.text = L10n.geoSearchOptionsTextTitle
            $0.textColor = UIColor.black
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(tickerImageView.snp.trailing).offset(15)
                make.top.equalTo(tickerImageView.snp.top)
                make.trailing.equalToSuperview().offset(20)
            })
        }
        doneButton.do {
            view.addSubview($0)
            $0.setTitle(L10n.titleDone, for: .normal)
            $0.snp.makeConstraints({ make in
                make.trailing.equalToSuperview()
                make.centerY.equalTo(titleView.snp.centerY)
            })
        }
        searchFieldView.do {
            view.addSubview($0)
            $0.textColor = UIColor.lightGray
            $0.placeholder = L10n.geoSearchOptionsTextMessage
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(titleView.snp.leading)
                make.top.equalTo(titleView.snp.bottom)
                make.trailing.equalTo(titleView.snp.trailing)
            })
        }
        keywordCollectionView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(searchFieldView.snp.bottom)
                make.bottom.equalToSuperview()
            })
        }
        reactor?.action.onNext(.loadKeywords(keywords))
    }
}

extension TextSubSearchViewController: View, HasDisposeBag {
    func bind(reactor: TextSubSearchReactor) {

        keywordCollectionView.rx.itemSelected
            .map { Reactor.Action.tapsSuggestionKeyword($0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        searchFieldView.rx.text
            .debounce(0.5, scheduler: MainScheduler.instance)
            .map { Reactor.Action.setSearchKeyword($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        doneButton.rx.tap
            .map { Reactor.Action.tapsDone }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.keywordSections }
            .filterNil()
            .distinctUntilChanged()
            .bind(to: keywordCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        reactor.state.map { $0.resultSearchKeyword }
            .filterNil()
            .bind { [weak self] keyword in
                self?.searchHandler?(keyword)
                self?.hero.dismissViewController()
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.tapsSuggestionKeyword }
            .filterNil()
            .bind { [weak self] text in
                logger.info("keyword: \(text)")
                self?.searchFieldView.text = text
            }
            .disposed(by: disposeBag)
    }
}
