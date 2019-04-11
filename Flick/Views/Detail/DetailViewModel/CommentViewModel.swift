//
//  Commant.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

class CommentViewModel: Commentable {
    let id: String
    let author: String
    let authorName: String
    let authorIsDeleted: Int
    let iconserver: String
    let iconfarm: Int
    let datecreate: String
    let permalink: String
    let realname: String
    let content: String

    public init(id: String, author: String, authorName: String, authorIsDeleted: Int, iconserver: String, iconfarm: Int, datecreate: String, permalink: String, realname: String, content: String) {
        self.id = id
        self.author = author
        self.authorName = authorName
        self.authorIsDeleted = authorIsDeleted
        self.iconserver = iconserver
        self.iconfarm = iconfarm
        self.datecreate = datecreate
        self.permalink = permalink
        self.realname = realname
        self.content = content
    }
}

extension CommentViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? CommentViewModel else { return false }
        return id == object.id && content == object.content
    }
}
