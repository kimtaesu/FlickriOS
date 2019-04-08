//
//  Convert+Int.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String? {
    var toInt: Int? {
        if let int = self {
            return Int(int ?? "")
        }
        return nil
    }
    var toDouble: Double? {
        if let double = self {
            return Double(double ?? "")
        }
        return nil
    }
}

extension String {
    var toInt: Int {
        return Int(self) ?? 0
    }
    var toDouble: Double {
        return Double(self) ?? 0.0
    }
}
