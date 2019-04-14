//
//  PhotoContext.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct PhotoResponse: Decodable {
    let photos: PhotoContext
}

struct PhotoContext: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

extension PhotoContext {
    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perpage
        case total
        case photo
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try values.decode(Int.self, forKey: .page)
        pages = try values.decode(Int.self, forKey: .pages)
        perpage = try values.decode(Int.self, forKey: .perpage)
        total = (try values.decode(String.self, forKey: .total)).toInt
        photo = try values.decode([Photo].self, forKey: .photo)
    }
    
    var isFirstPage: Bool {
        return page <= 1
    }
}
