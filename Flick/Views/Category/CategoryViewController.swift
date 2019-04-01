//
//  HomeViewController.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Hero
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

    private let favoriteView = UIView()
    // TODO Favorite
    // TODO Gallary
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.do {
            $0.backgroundColor = .white
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
        reactor.action.onNext(.fetchRecent)
        reactor.action.onNext(.fetchInteresting)

        reactor.state.map { $0.items }
            .filterEmpty()
            .bind(to: adapter.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension CategoryViewController: ListSectionDelegate {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        reactor = CategoryReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!)
    }

    func didSelectItem(at index: Int, item: Any, cell: UICollectionViewCell) {
        logger.info("didSelectItem: \(item)")
        guard let photo = item as? Photo else { return }

        if let cell = cell as? RecentThumbnailCell {
            cell.do {
                $0.thumbnailView.hero.isEnabled = true
            }
            let photoVC = PhotoDetailViewController(photo).then {
                $0.hero.isEnabled = true
                $0.originalImageView.hero.id = "image_\(index)"
            }
            let vc = UINavigationController(rootViewController: photoVC).then {
                $0.hero.isEnabled = true
            }
            self.present(vc, animated: true)
        }
    }
}

final class CategoryDataSource: NSObject, ListAdapterDataSource, RxListAdapterDataSource {
    typealias Element = [ListDiffable]

    var elements: Element = []
    weak var delegate: ListSectionDelegate?

    func setDelegate(_ delegate: ListSectionDelegate) {
        self.delegate = delegate
    }
    func listAdapter(_ adapter: ListAdapter, observedEvent: Event<[ListDiffable]>) {
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
