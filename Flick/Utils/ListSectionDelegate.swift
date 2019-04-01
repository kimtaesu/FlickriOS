//
//  ListSectionDelegate.swift
//  Flick
//
//  Created by tskim on 01/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

protocol ListSectionDelegate: class {
    func didSelectItem<T>(at index: Int, item: T)
}
