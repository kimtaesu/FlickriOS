//
//  HomeViewController.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import ReactorKit
import RxDataSources
import RxOptional
import UIKit

class RecentViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        return collectionView
    }()

    private let dataSources = RxCollectionViewSectionedAnimatedDataSource<ThumbnailSection>(
        configureCell: { ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: RecentCell.swiftIdentifier, for: ip) as? RecentCell else { return UICollectionViewCell() }
            cell.configCell(item)
            return cell
        }
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.do {
            $0.backgroundColor = UIColor.white
            $0.register(RecentCell.self, forCellWithReuseIdentifier: RecentCell.swiftIdentifier)
            $0.dataSource = dataSources
        }
        view = collectionView
    }
}

extension RecentViewController: View, HasDisposeBag {
    func bind(reactor: RecentReactor) {
        reactor.action.onNext(.recent)
        reactor.state.map { $0.thumbnails }
            .filterNil()
            .distinctUntilChanged()
            .do(onNext: { logger.info("A thumbnails rendering \($0)") })
            .bind(to: collectionView.rx.items(dataSource: dataSources))
            .disposed(by: disposeBag)
    }
}

extension RecentViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        reactor = RecentReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!)
    }
}
