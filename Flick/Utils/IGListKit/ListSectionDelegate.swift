//
//  ListSectionDelegate.swift
//  Flick
//
//  Created by tskim on 01/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit

protocol ListSectionDelegate: class {
    func didSelectItem(at index: Int, item: Any, cell: UICollectionViewCell)
}
