//
//  LocationResultSet.swift
//  Flick
//
//  Created by tskim on 07/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct LocationResultSet: Decodable {
    let results: [LocationResult]?
    
    enum CoadingKeys: String, CodingKey {
        case resultSet = "ResultSet"
        case result = "Result"
    }
}

extension LocationResultSet {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CoadingKeys.self)
        let resultSets = try values.nestedContainer(keyedBy: CoadingKeys.self, forKey: .resultSet)
        results = try? resultSets.decode([LocationResult].self, forKey: .result)
    }
}
