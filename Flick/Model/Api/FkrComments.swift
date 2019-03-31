//
//  FkrComments.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct FkrCommentRequest: HasPhotoId {
    let photo_id: String
    let min_comment_date: String?
    let max_comment_date: String?

    public init(photo_id: String, min_comment_date: String? = nil, max_comment_date: String? = nil) {
        self.photo_id = photo_id
        self.min_comment_date = min_comment_date
        self.max_comment_date = max_comment_date
    }
    
}

extension FkrCommentRequest: Codable {
    enum CodingKeys: String, CodingKey {
        case photo_id
        case min_comment_date
        case max_comment_date
    }
}
