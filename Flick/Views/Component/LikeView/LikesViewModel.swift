//
//  LikesViewModel.swift
//  Flick
//
//  Created by tskim on 12/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

enum LikesType {
    case views
    case comments
    case likes
}
struct LikesViewModel {
    let type: LikesType
    let count: Int
    let image: UIImage
}
