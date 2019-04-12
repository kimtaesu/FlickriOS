//
//  IconBuddyFactory.swift
//  Flick
//
//  Created by tskim on 12/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

func makeIconBuddy(owner: String, farm: Int, iconServer: String) -> String {
    return "https://farm\(farm).staticflickr.com/\(iconServer)/buddyicons/\(owner).jpg"
}

extension Photo {
    var iconBuddy: String {
        return makeIconBuddy(owner: owner, farm: iconFarm, iconServer: iconServer)
    }
}

extension Comment {
    var iconBuddy: String {
        return makeIconBuddy(owner: author, farm: iconfarm, iconServer: iconserver)
    }
}
