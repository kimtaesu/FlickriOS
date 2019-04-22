//
//  PhotoError.swift
//  Flick
//
//  Created by tskim on 15/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

enum PhotoError: Error, LocalizedError {
    case network
    
    var errorDescription: String? {
        switch self {
        case .network:
            return "네트워크 오류로 실패"
        }
    }
}
