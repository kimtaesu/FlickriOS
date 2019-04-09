//
//  PhotoAnnotations.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import MapKit

class PhotoAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let photo: Photo

    public init(photo: Photo) {
        self.coordinate = photo.location
        self.photo = photo
        super.init()
    }
}
