//
//  CommentResponse.swift
//  Flick
//
//  Created by tskim on 01/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct CommentResponse: Decodable {
    let comments: CommentContext
}

struct CommentContext: Decodable {
    let photoId: String
    let comment: [Comment]?
}
extension CommentContext {
    enum CodingKeys: String, CodingKey {
        case photoId = "photo_id"
        case comment
    }
}
