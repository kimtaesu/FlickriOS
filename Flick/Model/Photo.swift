//
//  Photo.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let owner: String
    let secret: String
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
    let dateupload: String
    let lastupdate: String
    let datetaken: String
    let ownername: String
    let views: String
    let machine_tags: String
    let originalsecret: String
    let originalformat: String
    let latitude: Float
    let longitude: Float
    let accuracy: Int
    let media: String
    let media_status: String
    
    let url_sq: String
    let height_sq: Int
    let width_sq: Int
    
    let url_t: String
    let height_t: Int
    let width_t: Int
    
    let url_s: String
    let height_s: Int
    let width_s: Int
    
    let url_q: String
    let height_q: Int
    let width_q: Int
    
    let url_m: String
    let height_m: Int
    let width_m: Int
    
    let url_o: String
    let height_o: Int
    let width_o: Int
}
