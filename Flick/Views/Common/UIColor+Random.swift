//
//  UIColor+Random.swift
//  Flick
//
//  Created by tskim on 10/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
import UIKit

public extension CGFloat {
    public static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

public extension UIColor {
    public static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}
