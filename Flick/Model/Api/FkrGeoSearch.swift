//
//  FkrSearch.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct FkrGeoSearchReq: HasPagableProtocol, HasContentType {
    let text: String
    let page: Int
    let bbox: String
    let per_page: Int
    let sort: String
    let content_type: Int
    let accuracy: Int
    let format: String = "json"
    let nojsoncallback: String = "?"
    
    init(
        text: String,
        page: Int,
        bbox: String,
        sort: String = SortOption.interesting.rawValue,
        perPage: Int = Enviroment.DEFAULT_PER_PAGE,
        contentType: Int = ContentType.photoOnly.rawValue,
        accuracy: Int = 1
        ) {
        self.text = text
        self.page = page
        self.per_page = perPage
        self.sort = sort
        self.content_type = contentType
        self.bbox = bbox
        self.accuracy = accuracy
    }
}

extension FkrGeoSearchReq: Codable {
    enum CodingKeys: String, CodingKey {
        case text
        case page
        case bbox
        case per_page
        case sort
        case content_type
        case accuracy
        case format
        case nojsoncallback
    }
}
