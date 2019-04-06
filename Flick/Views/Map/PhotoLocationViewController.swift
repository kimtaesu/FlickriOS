//
//  MapViewController.swift
//  Flick
//
//  Created by tskim on 05/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import MapKit
import RxSwift
import UIKit

class PhotoLocationViewController: UIViewController {

    let mapView = MKMapView()
    private var markLocation: CLLocationCoordinate2D!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(latitude: Double, longitude: Double) {
        super.init(nibName: nil, bundle: nil)
        self.markLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        initLocation(self.markLocation, zoomLevel: self.preferZoomLevel)
    }
    
    func initLocation(_ location: CLLocationCoordinate2D, zoomLevel: Int) {
        Observable.merge(self.rx.viewDidLoad.map { _ in true }, self.rx.viewDidAppear.map { _ in true }.take(1))
            .bind { [weak self] in
                guard let self = self else { return }
                self.mapView.setCenterCoordinate(self.markLocation, withZoomLevel: self.preferZoomLevel, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.do {
            view = mapView
            $0.addAnnotation(MKPointAnnotation().then {
                $0.coordinate = markLocation
                $0.title = "title test"
                $0.subtitle = "subtitle"
            })
        }
    }
}

extension PhotoLocationViewController: HasDisposeBag {
    var preferZoomLevel: Int {
        return 18
    }
}
