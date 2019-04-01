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

    lazy private var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 4)
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let dataSource = CategoryDataSource()
    
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
            $0.rx.setDataSource(dataSource).disposed(by: disposeBag)
            $0.collectionView = collectionView
        }
    }
}

extension CategoryViewController: View, HasDisposeBag {
    func bind(reactor: CategoryReactor) {
        reactor.action.onNext(.fetchData)

        reactor.state.map { $0.items }
            .filterNil()
            .filterEmpty()
            .distinctUntilChanged()
            .bind(to: adapter.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension CategoryViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        reactor = CategoryReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!)
    }
}
