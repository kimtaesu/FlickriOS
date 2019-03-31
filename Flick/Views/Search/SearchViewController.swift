//
//  SearchViewController.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import RxDataSources
import UIKit
import RxSwift

class SearchViewController: UIViewController {

    private let uiSearchBar = UISearchBar()
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()

    private let dataSources = RxCollectionViewSectionedAnimatedDataSource<ThumbnailSection>(
        configureCell: { ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: RecentThumbnailCell.swiftIdentifier, for: ip) as? RecentThumbnailCell else { return UICollectionViewCell() }
            cell.configCell(item)
            return cell
        }
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        uiSearchBar.do {
            let accessoryView = SearchInputAccessoryView().then {
                $0.bounds.size = CGSize(width: view.frame.width, height: 30)
            }
            $0.inputAccessoryView = accessoryView
            accessoryView.hideKeyboardButton.addTarget(self, action: #selector(hideKeyboard), for: .touchUpInside)
            view.addSubview($0)
            $0.placeholder = "Start search..."
            $0.snp.makeConstraints({ make in
                make.top.equalTo(self.safeAreaTop)
                make.leading.centerX.equalToSuperview()
            })
        }
        collectionView.do {
            $0.backgroundColor = UIColor.white
            $0.register(RecentThumbnailCell.self, forCellWithReuseIdentifier: RecentThumbnailCell.swiftIdentifier)
            $0.dataSource = dataSources
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.top.equalTo(uiSearchBar.snp.bottom)
                make.leading.centerX.equalToSuperview()
                make.bottom.equalToSuperview()
            })
        }
    }

    @objc
    func hideKeyboard() {
        uiSearchBar.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.uiSearchBar.becomeFirstResponder()
        }
    }
}

extension SearchViewController: View, HasDisposeBag {
    func bind(reactor: SearchReactor) {
        uiSearchBar.rx.text
            .debounce(0.5, scheduler: MainScheduler.asyncInstance)
            .filterNil()
            .map { Reactor.Action.setText($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        uiSearchBar.rx.searchButtonClicked
            .map { Reactor.Action.search }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.showKeyboard }
            .asDriver(onErrorJustReturn: nil)
            .filterNil()
            .distinctUntilChanged()
            .drive(onNext: { [weak self] isShow in
                self?.uiSearchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.thumbnails }
            .filterNil()
            .distinctUntilChanged()
            .do(onNext: { logger.info("A thumbnails rendering \($0)") })
            .bind(to: collectionView.rx.items(dataSource: dataSources))
            .disposed(by: disposeBag)
    }
}

extension SearchViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        reactor = SearchReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!)
    }
}
