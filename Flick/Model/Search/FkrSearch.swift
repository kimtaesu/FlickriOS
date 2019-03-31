//
//  FkrSearch.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

enum Method: String {
    case Search = "flickr.photos.search"
}

enum ContentType: Int {
    case photoOnly = 1
    case screentShotsOnly = 2
    case otherOnly = 3
    case photoAndScreenshots = 4
    case screentShotOther = 5
    case photoOther = 6
    case all = 7
}

struct FkrSearchRequest {
    let text: String
    let page: Int
    let perPage: Int
    let extras: String
    let method: String
    let format: String
    let sort: String
    let contentType: Int
    let nojsoncallback: String
    
    init(
        text: String,
        page: Int,
        sort: String = "date-taken-desc",
        perPage: Int = 20,
        extras: String = "description, url_o, url_s, date_taken",
        method: String = Method.Search.rawValue,
        format: String = "json",
        nojsoncallback: String = "nojsoncallback",
        contentType: Int = ContentType.photoOnly.rawValue
        ) {
        self.text = text
        self.method = method
        self.page = page
        self.perPage = perPage
        self.extras = extras
        self.format = format
        self.sort = sort
        self.contentType = contentType
        self.nojsoncallback = nojsoncallback
    }
}

extension FkrSearchRequest: Codable {
    enum CodingKeys: String, CodingKey, CaseIterable {
        case text
        case page
        case perPage
        case extras
        case method
        case format
        case sort
        case contentType
        case nojsoncallback
    }
}

struct FkrSearchResponse: Decodable {
    let photos: [PhotoContext]
}
