//
//  SelectedLocationAnnotation.swift
//  Flick
//
//  Created by tskim on 13/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import MapKit

class SelectedLocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    public init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
