//
//  CommentSection.swift
//  Flick
//
//  Created by tskim on 12/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxDataSources

struct CommentSection: Equatable {
    var header: String
    var items: [Item]
}

extension CommentSection: AnimatableSectionModelType {
    typealias Item = Comment
    
    var identity: String {
        return header
    }
    
    init(original: CommentSection, items: [Item]) {
        self = original
        self.items = items
    }
}

extension Comment: IdentifiableType {
    var identity: String {
        return id
    }
    
    typealias Identity = String
}
