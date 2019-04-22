////
////  FkrSearch.swift
////  Flick
////
////  Created by tskim on 30/03/2019.
////  Copyright © 2019 hucet. All rights reserved.
////
//
//import Foundation
//
//struct FkrSearchRequest: HasPagableProtocol, HasContentType {
//    let text: String
//    let page: Int
//    let per_page: Int
//    let sort: String
//    let content_type: Int
//    
//    init(
//        text: String,
//        page: Int,
//        sort: String = "date-taken-desc",
//        perPage: Int = Enviroment.DEFAULT_PER_PAGE,
//        contentType: Int = ContentType.photoOnly.rawValue
//        ) {
//        self.text = text
//        self.page = page
//        self.per_page = perPage
//        self.sort = sort
//        self.content_type = contentType
//    }
//}
//
//extension FkrSearchRequest: Codable {
//    enum CodingKeys: String, CodingKey {
//        case text
//        case page
//        case per_page
//        case sort
//        case content_type
//    }
//}
