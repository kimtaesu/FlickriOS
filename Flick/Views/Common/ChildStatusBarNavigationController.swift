//
//  ChildStatusBarNavigationController.swift
//  Flick
//
//  Created by tskim on 12/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class ChildStatusBarNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
