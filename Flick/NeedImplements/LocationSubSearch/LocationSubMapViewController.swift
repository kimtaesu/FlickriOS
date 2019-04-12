//
//  LocationSubMapViewController.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class LocationSubMapViewController: UIViewController {

    let mapView = MKMapView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ locationResult: LocationResult) {
        super.init(nibName: nil, bundle: nil)
        mapView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
