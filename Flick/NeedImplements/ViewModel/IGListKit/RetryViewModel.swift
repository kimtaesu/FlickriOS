//
//  PhotoError.swift
//  Flick
//
//  Created by tskim on 02/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

class RetryViewModel: NSObject, ViewModelProtocol { }

extension RetryViewModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
}
