//
//  Comment.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

protocol Commentable {
    var id: String { get }
    var author: String { get }
    var authorName: String { get }
    var authorIsDeleted: Int { get }
    var iconserver: String { get }
    var iconfarm: Int { get }
    var datecreate: String { get }
    var permalink: String { get }
    var realname: String { get }
    var content: String { get }
}
struct Comment: Decodable, Equatable, Commentable {
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
}

extension Comment {
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case authorName = "authorname"
        case authorIsDeleted = "author_is_deleted"
        case iconserver
        case iconfarm
        case datecreate
        case realname
        case permalink
        case content = "_content"
    }
}
