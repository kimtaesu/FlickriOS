//
//  UserViewModel.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

class UserViewModel: ListDiffable {
    let iconBuddy: String
    let ownerId: String
    let ownerName: String?
    let dateupload: String?
    let lastupdate: String?
    let datetaken: String?

    public init(_ photo: Photo) {
        self.iconBuddy = photo.iconBuddy
        self.ownerId = photo.owner
        self.ownerName = photo.ownername
        self.dateupload = photo.dateupload
        self.lastupdate = photo.lastupdate
        self.datetaken = photo.datetaken
    }

    func diffIdentifier() -> NSObjectProtocol {
        return ownerId as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? UserViewModel else { return false }
        return ownerName == object.ownerName
            && ownerId == object.ownerId
    }
}
