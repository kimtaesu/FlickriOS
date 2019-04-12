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
    let defaultCenterLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    let mapView = MKMapView()
    let photoContainer = PhotoViewController()
    let locationManager = CLLocationManager()
    
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
        self.navigationController?.isNavigationBarHidden = true
        setNeedsStatusBarAppearanceUpdate()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        mapView.do {
            view.addSubview($0)
            $0.delegate = self
            $0.showsUserLocation = true
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
            
            let region = MKCoordinateRegion(center: locationManager.currentCoordinate, span: mapView.maxZoomSpan)
            $0.setRegion(region, animated: true)
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
    }
    func createDetailViewController(_ annotation: PhotoAnnotation) -> UIViewController {
        let vc = PhotoDetailViewController(annotation.photo).then {
            $0.imageView.hero.id = "hero_photo_id_\(annotation.photo.id)"
        }
        return ChildStatusBarNavigationController(rootViewController: vc).then {
            $0.hero.isEnabled = true
        }
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
            .distinctUntilChanged()
            .bind { [weak self] annotations in
                guard let self = self else { return }
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotations(annotations)
            }
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
            self.present(createDetailViewController(annotation), animated: true)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PhotoAnnotation {
            var view: PhotoAnnotationView
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: PhotoAnnotationView.swiftIdentifier) as? PhotoAnnotationView {
                view = annotationView
            } else {
                view = PhotoAnnotationView(annotation: annotation, reuseIdentifier: PhotoAnnotationView.swiftIdentifier)
            }
            return view.then {
                let annotationAccessoryView = PhotoDetailAnnotationAccessoryView(annotation: annotation).then {
                    $0.configCell(annotation)
                    $0.thumbnailView.hero.id = "hero_photo_id_\(annotation.photo.id)"
                }
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

extension PhotoGeoViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.centerCoordinate = manager.currentCoordinate
        default:
            break
        }
    }
}

extension CLLocationManager {
    var currentCoordinate: CLLocationCoordinate2D {
        return self.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
}
