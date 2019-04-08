//
//  HasExtrasProtocol.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

enum Extras: String, CaseIterable {
    case description
    case license
    case date_upload
    case date_taken
    case owner_name
    case icon_server
    case original_format
    case last_update
    case geo
    case tags
    case machine_tags
    case count_comments
    case count_faves
    case o_dims
    case views
    case media
    case path_alias
    case url_sq
    case url_t
    case url_s
    case url_q
    case url_m
    case url_n
    case url_z
    case url_c
    case url_l
    case url_o

    private static var commonAttrs: [Extras] {
        return [
                .description,
                .date_upload,
                .date_taken,
                .owner_name,
                .icon_server,
                .last_update,
                .url_m,
                .url_o,
                .views,
                .count_comments,
                .count_faves,
                .tags,
                .media
        ]
    }

    static var allAttrs: String {
        return Extras.allCases.map { $0.rawValue }.joined(separator: ",")
    }
    
    static var geoAttrs: String {
        let attrs: [Extras] = [.geo]
        let resultAttrs = commonAttrs + attrs
        return resultAttrs.map { $0.rawValue }.joined(separator: ",")
    }

    static let key = "extras"
}
