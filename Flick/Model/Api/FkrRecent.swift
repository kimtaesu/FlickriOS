//
//  FkrRecent.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct FkrRecentRequest: HasPagableProtocol {
    let page: Int
    let per_page: Int
    
    public init(page: Int, perPage: Int = Enviroment.DEFAULT_PER_PAGE) {
        self.page = page
        self.per_page = perPage
    }
}

extension FkrRecentRequest: Codable {
    enum CodingKeys: String, CodingKey {
        case page
        case per_page
    }
}
