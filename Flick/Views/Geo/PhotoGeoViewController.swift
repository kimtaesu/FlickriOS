//
//  PhotoGeoViewController.swift
//  Flick
//
//  Created by tskim on 07/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import MapKit
import ReactorKit
import RxDataSources
import UIKit

class PhotoGeoViewController: UIViewController {

    let mapView = MKMapView()
    let currentLocationView = UIImageView()
    let photoCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(PhotoGeoCell.self, forCellWithReuseIdentifier: PhotoGeoCell.swiftIdentifier)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()

    let dataSource = RxCollectionViewSectionedAnimatedDataSource<PhotoSection>(
        configureCell: { ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withReuseIdentifier: PhotoGeoCell.swiftIdentifier, for: ip) as? PhotoGeoCell else {
                return UICollectionViewCell()
            }
            cell.configCell(item)
            return cell
        }
    )

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        reactor = PhotoGeoReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentLocationView.do {
            view.addSubview($0)
            $0.image = Asset.icCurrentLocation.image
            $0.snp.makeConstraints({ make in
                let width = 20
                make.width.equalTo(width)
                make.height.equalTo(width)
                make.leading.equalToSuperview().offset(20)
                make.top.equalTo(safeAreaTop).offset(20)
            })
        }
        mapView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
        photoCollectionView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalTo(70)
                make.bottom.equalTo(safeAreaBottom).offset(-50)
            })
        }
        view.bringSubviewToFront(currentLocationView)
    }

}

extension PhotoGeoViewController: View, HasDisposeBag {
    func bind(reactor: PhotoGeoReactor) {
        reactor.action.onNext(.setSearch)

        photoCollectionView.rx.itemSelected
            .map { Reactor.Action.tapsPhoto($0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.selectedPhoto }
            .filterNil()
            .bind { [weak self] photo in
                self?.mapView.setCenterCoordinate(photo.location, withZoomLevel: 18, animated: true)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.photoSections }
            .filterEmpty()
            .bind(to: photoCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
