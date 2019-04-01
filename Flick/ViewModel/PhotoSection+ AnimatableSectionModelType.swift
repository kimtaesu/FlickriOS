//
//  ThumbnailViewModel+An.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
import RxDataSources

extension PhotoSection: AnimatableSectionModelType {
    typealias Item = Photo
    
    var identity: String {
        return header
    }
    
    init(original: PhotoSection, items: [Item]) {
        self = original
        self.items = items
    }
}
