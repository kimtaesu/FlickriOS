//
//  ViewStyle.swift
//  Flick
//
//  Created by tskim on 14/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

struct ViewStyle<T> {
    let style: (T) -> T
}

protocol Stylable {
    init()
}

extension UIView: Stylable {}

extension Stylable {
    
    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }
    
    func apply(_ style: ViewStyle<Self>) -> Self {
        return style.style(self)
    }
}
