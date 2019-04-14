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

    let keywordCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(TextSubCell.self, forCellWithReuseIdentifier: TextSubCell.swiftIdentifier)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(searchHandler: ((String) -> Void)? = nil) {
        self.searchHandler = searchHandler
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.white
        reactor = TextSubSearchReactor(keywords: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSearchView()
        tickerImageView.image = Asset.icTextFormat.image
        titleView.text = L10n.geoSearchOptionsTextTitle
        titleView.textColor = UIColor.gray
        searchFieldView.do {
            $0.attributedPlaceholder = NSAttributedString(
                string: L10n.geoSearchOptionsTextMessage,
                attributes: [NSAttributedString.Key.foregroundColor: ColorName.placeholderGray])
        }
        keywordCollectionView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.trailing.equalToSuperview().offset(-20)
                make.leading.equalTo(titleView.snp.leading)
                make.top.equalTo(searchFieldView.snp.bottom).offset(16)
                make.bottom.equalToSuperview()
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.searchFieldView.becomeFirstResponder()
            self?.searchFieldView.selectAll(nil)
        }
    }
}

extension TextSubSearchViewController: View, HasDisposeBag {
    func bind(reactor: TextSubSearchReactor) {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<TextSubSection>(
            configureCell: { ds, tv, ip, item in
                guard let cell = tv.dequeueReusableCell(withReuseIdentifier: TextSubCell.swiftIdentifier, for: ip) as? TextSubCell else {
                    return UICollectionViewCell()
                }
                cell.configCell(item)
                cell.hero.modifiers = [
                        .delay(0.1),
                        .timingFunction(.easeIn),
                        .fade,
                        .translate(x: 0, y: tv.frame.height, z: 0)
                ]
                return cell
            }
        )

        reactor.action.onNext(.loadKeywords(keywords))
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
