//
//  LoadingViewModel.swift
//  Flick
//
//  Created by tskim on 01/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

class LoadingViewModel: NSObject, ViewModelProtocol { }

extension LoadingViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
}

extension LoadingViewModel {
    class func generateThumbnails(_ count: Int) -> [LoadingViewModel] {
        var items: [LoadingViewModel] = []
        for _ in 0..<count {
            items.append(LoadingViewModel())
        }
        return items
    }
}
