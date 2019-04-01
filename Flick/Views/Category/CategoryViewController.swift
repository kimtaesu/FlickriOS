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
import RxCocoa
import RxDataSources
import RxOptional
import RxSwift
import UIKit

class CategoryViewController: UIViewController {

    lazy private var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 4)
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let dataSource = CategoryDataSource()
    
    private var aaa: ListSectionDelegate?
    
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
        dataSource.do {
            $0.setDelegate(self)
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

extension CategoryViewController: ListSectionDelegate {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        reactor = CategoryReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!)
    }
    func didSelectItem<T>(at index: Int, item: T) {
    }
}

final class CategoryDataSource: NSObject, ListAdapterDataSource, RxListAdapterDataSource {
    typealias Element = [RecentItem]
    
    var elements: Element = []
    weak var delegate: ListSectionDelegate?
    
    func setDelegate(_ delegate: ListSectionDelegate) {
        self.delegate = delegate
    }
    func listAdapter(_ adapter: ListAdapter, observedEvent: Event<[RecentItem]>) {
        if case .next(let items) = observedEvent {
            elements = items
            adapter.performUpdates(animated: true)
        }
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return elements
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return RecentThumbnailSectionController().then {
            if let delegate = self.delegate {
                $0.setDelegate(delegate)
            }
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
