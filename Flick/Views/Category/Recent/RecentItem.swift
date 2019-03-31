//
//  RecentItem.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

final class RecentItem: NSObject {
    var items: [Thumbnail] = []

    public init(items: [Thumbnail] = []) {
        self.items = items
    }
}

extension RecentItem: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}
