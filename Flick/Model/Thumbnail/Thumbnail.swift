//
//  Thumbnail.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxDataSources

struct Thumbnail: Equatable {
    let thumbnail: ImageSource
    let original: ImageSource
    let id: String
}

extension Thumbnail: IdentifiableType {
    typealias Identity = String
    
    var identity: String {
        return id
    }
}
