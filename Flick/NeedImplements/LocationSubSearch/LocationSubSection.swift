//
//  LocationAA.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxDataSources

extension LocationResult: IdentifiableType {
    var identity: String {
        return self.woeWoeId
    }
}

struct LocationSubSection: Equatable {
    var header: String
    var items: [Item]
}

extension LocationSubSection: AnimatableSectionModelType {
    typealias Item = LocationResult
    
    var identity: String {
        return header
    }
    
    init(original: LocationSubSection, items: [Item]) {
        self = original
        self.items = items
    }
}
