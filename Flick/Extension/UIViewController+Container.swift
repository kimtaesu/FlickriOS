//
//  UIViewController+Container.swift
//  Flick
//
//  Created by tskim on 05/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

extension UIViewController {
    func removeViewContainer(_ target: UIViewController) {
        target.willMove(toParent: nil)
        target.removeFromParent()
        target.view.removeFromSuperview()
        target.didMove(toParent: nil)
    }
    
    func addViewContainer(_ target: UIViewController) {
        target.willMove(toParent: self)
        self.addChild(target)
        view.addSubview(target.view)
        target.didMove(toParent: nil)
    }
}
