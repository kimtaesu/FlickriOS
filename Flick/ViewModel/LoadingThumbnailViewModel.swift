//
//  LoadingViewModel.swift
//  Flick
//
//  Created by tskim on 01/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

protocol Thumbnailable { }

class LoadingThumbnailViewModel: NSObject, Thumbnailable { }

extension LoadingThumbnailViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
}

extension LoadingThumbnailViewModel {
    class func generateThumbnails(_ count: Int) -> [LoadingThumbnailViewModel] {
        return [0..<count].enumerated().map { i, c in
            LoadingThumbnailViewModel()
        }
    }
}
