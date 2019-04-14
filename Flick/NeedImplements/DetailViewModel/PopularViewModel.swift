//
//  PopularViewModel.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

class PopularViewModel: ListDiffable {
    let id: String
    let countComments: String
    let countLikes: String
    let views: String

    init(_ photo: Photo) {
        self.id = photo.id
        self.countComments = "\(photo.countComments)"
        self.countLikes = "\(photo.countLikes)"
        self.views = "\(photo.views)"
    }
    func diffIdentifier() -> NSObjectProtocol {
        return "popular" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? PopularViewModel else { return false }
        return self.id == object.id &&
            self.countLikes == object.countLikes &&
            self.countComments == object.countComments &&
            self.views == object.views
    }
}
