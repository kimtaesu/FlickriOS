//
//  MethodParam.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

enum Method: String {
    case search = "flickr.photos.search"
    case recent = "flickr.photos.getRecent"
    case interesting = "flickr.interestingness.getList"
    case comment = "flickr.photos.comments.getList"
    
    static let key = "method"
}
