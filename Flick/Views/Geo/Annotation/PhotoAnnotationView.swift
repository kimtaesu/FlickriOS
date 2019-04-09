//
//  PhotoAnnotationView.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class PhotoAnnotationView: MKAnnotationView, SwiftNameIdentifier {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        guard let photoAnnotation = self.annotation as? PhotoAnnotation else { return }
        image = Asset.icHome.image
    }
}
