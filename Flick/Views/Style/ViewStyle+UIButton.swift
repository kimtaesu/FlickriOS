//
//  ViewStyle+UIButton.swift
//  Flick
//
//  Created by tskim on 14/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

extension ViewStyle where T: UIButton {
    static func floatingAction() -> ViewStyle<UIButton> {
        return ViewStyle<UIButton> {
            $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            $0.layoutIfNeeded()
            $0.layer.cornerRadius = $0.bounds.width / 2
            $0.tintColor = UIColor.white
            $0.backgroundColor = ColorName.colorAccent
            $0.layer.do {
                $0.shadowOpacity = 1
                $0.shadowRadius = 2
                $0.shadowOffset = CGSize(width: 1, height: 1)
                $0.shadowColor = UIColor.gray.cgColor
            }
            return $0
        }
    }
}
