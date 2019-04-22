//
//  CLLocationManager+.swift
//  Flick
//
//  Created by tskim on 14/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationManager {
    var currentCoordinate: CLLocationCoordinate2D {
        return self.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
}
