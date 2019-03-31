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
        do {
            if let stringInt = self {
                return try Int(stringInt ?? "")
            }
            return nil
        } catch {
            return nil
        }
    }
}

extension String {
    var toInt: Int {
        do {
            return try Int(self) ?? 0
        } catch {
            return 0
        }
    }
}
