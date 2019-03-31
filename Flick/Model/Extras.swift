//
//  HasExtrasProtocol.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

enum Extras: String, CaseIterable {
    case date_upload
    case date_taken
    case owner_name
    case icon_server
    case original_format
    case last_update
    case geo
    case tags
    case machine_tags
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

    static var allAttrs: String {
        return Extras.allCases.map { $0.rawValue }.joined(separator: ",")
    }

    static let key = "extras"
}
