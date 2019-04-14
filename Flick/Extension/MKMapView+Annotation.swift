//
//  MKMapView+Annotation.swift
//  Flick
//
//  Created by tskim on 13/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    func clearAnnotations() {
        self.removeAnnotations(self.annotations)
    }
}
