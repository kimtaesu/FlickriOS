//
//  GeoSearchOption.swift
//  Flick
//
//  Created by tskim on 07/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxDataSources

enum SearchAction: Int, Equatable {
    case text = 0
    case location = 1
}

struct GeoSearchOption: IdentifiableType, Equatable {
    let tickerImage: UIImage
    let title: String
    var message: String
    let searchAction: SearchAction

    var identity: String {
        return title
    }
}

struct GeoSearchOptionSection: Equatable {
    var header: String
    var items: [Item]
}

extension GeoSearchOptionSection: AnimatableSectionModelType {
    typealias Item = GeoSearchOption

    var identity: String {
        return header
    }

    init(original: GeoSearchOptionSection, items: [Item]) {
        self = original
        self.items = items
    }
}
