//
//  Photo+CodingKeys.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

extension Photo {
    enum CodingKeys: String, CodingKey {
        typealias RawValue = String
        case id
        case owner
        case description
        case license 
        case secret
        case iconfarm
        case iconserver
        case title
        case ispublic
        case isfriend
        case isfamily
        case dateupload
        case lastupdate
        case datetaken
        case ownername
        case views
        case count_comments
        case count_faves
        case machine_tags
        case originalsecret
        case originalformat
        case latitude
        case longitude
        case accuracy
        case media
        case media_status

        case url_sq
        case height_sq
        case width_sq

        case url_t
        case height_t
        case width_t

        case url_s
        case height_s
        case width_s

        case url_l
        case height_l
        case width_l
        
        case url_q
        case height_q
        case width_q

        case url_m
        case height_m
        case width_m

        case url_n
        case height_n
        case width_n
        
        case url_z
        case height_z
        case width_z
        
        case url_c
        case height_c
        case width_c
        
        case url_o
        case height_o
        case width_o
    }
}
