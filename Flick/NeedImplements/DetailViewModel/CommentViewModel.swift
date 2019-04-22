//
//  Commant.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

class CommentViewModel: CommentableProtocol {
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

    public init(_ commentable: CommentableProtocol) {
        self.id = commentable.id
        self.author = commentable.author
        self.authorName = commentable.authorName
        self.authorIsDeleted = commentable.authorIsDeleted
        self.iconserver = commentable.iconserver
        self.iconfarm = commentable.iconfarm
        self.datecreate = commentable.datecreate
        self.permalink = commentable.permalink
        self.realname = commentable.realname
        self.content = commentable.content
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
