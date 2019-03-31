//
//  HomeViewController.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit
import ReactorKit
import RxDataSources
import RxOptional
import UIKit

class CategoryViewController: UIViewController {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var data: [ListDiffable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.do {
            $0.register(RecentThumbnailCell.self, forCellWithReuseIdentifier: RecentThumbnailCell.swiftIdentifier)
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
        adapter.do {
            $0.collectionView = collectionView
            $0.dataSource = self
        }
    }
}

extension CategoryViewController: View, HasDisposeBag {
    func bind(reactor: CategoryReactor) {
        reactor.action.onNext(.fetchData)

        reactor.state.map { $0.items }
            .asDriver(onErrorJustReturn: nil)
            .filterNil()
            .filterEmpty()
            .distinctUntilChanged()
            .drive(onNext: { items in
                self.data = items
                self.adapter.performUpdates(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension CategoryViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        reactor = CategoryReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!)
    }
}
