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
import RxMKMapView
import UIKit

class PhotoGeoViewController: UIViewController {
    let defaultCenterLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    let mapView = MKMapView()
    let photoContainer = PhotoViewController()
    let currentLocationView = UIImageView()
    
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
            $0.rx.setDelegate(self).disposed(by: disposeBag)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
        self.addViewContainer(photoContainer)
        photoContainer.view.do {
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

        photoContainer.leftPagingView.rx.tap
            .map { Reactor.Action.toLeft }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        photoContainer.rightPagingView.rx.tap
            .map { Reactor.Action.toRight }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.mapAnnotations }
            .filterEmpty()
            .bind(to: mapView.rx.annotations)
            .disposed(by: disposeBag)

        reactor.state.map { $0.selectedPhoto }
            .filterNil()
            .bind { [weak self] photo in
                self?.mapView.setCenterCoordinate(photo.location, withZoomLevel: 18, animated: true)
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.enabledLeft }
            .filterNil()
            .distinctUntilChanged()
            .bind(to: photoContainer.leftPagingView.rx.isEnabled)
            .disposed(by: disposeBag)

        reactor.state.map { $0.enabledRight }
            .filterNil()
            .distinctUntilChanged()
            .bind(to: photoContainer.rightPagingView.rx.isEnabled)
            .disposed(by: disposeBag)

        reactor.state.map { $0.selectedAnnotation }
            .filterNil()
            .bind { [weak self] annotation in
                guard let self = self else { return }
                let vc = PhotoDetailViewController(annotation.photo)
                self.show(vc, sender: self)
            }
            .disposed(by: disposeBag)
        
        photoContainer.photoCollectionView.rx.itemSelected
            .map { Reactor.Action.tapsPhoto($0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.photoSections }
            .filterNil()
            .bind(to: photoContainer.photoCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension PhotoGeoViewController: MKMapViewDelegate, PhotoAnnotationDelegate {
    func tapThumbnailView(_ annotation: MKAnnotation) {
        if let annotation = annotation as? PhotoAnnotation {
            self.show(PhotoDetailViewController(annotation.photo), sender: self)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PhotoAnnotation {
            return PhotoAnnotationView(annotation: annotation, reuseIdentifier: PhotoAnnotationView.swiftIdentifier).then {
                let annotationAccessoryView = PhotoDetailAnnotationAccessoryView(annotation: annotation).then { $0.configCell(annotation) }
                annotationAccessoryView.setDelegate(self)
                $0.detailCalloutAccessoryView = annotationAccessoryView
                $0.canShowCallout = true
                $0.calloutOffset = CGPoint(x: 0, y: -5)
                registerForPreviewing(with: self, sourceView: $0)
            }
        }
        return nil
    }
}
