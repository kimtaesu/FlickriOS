//
//  PhotoViewModel.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
import RxDataSources

struct PhotoSection: Equatable {
    var header: String
    var items: [Item]
}

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
