//
//  HasContentType.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

enum ContentType: Int {
    case photoOnly = 1
    case screentShotsOnly = 2
    case otherOnly = 3
    case photoAndScreenshots = 4
    case screentShotOther = 5
    case photoOther = 6
    case all = 7
}

protocol HasContentType {
    var content_type: Int { get }
}
