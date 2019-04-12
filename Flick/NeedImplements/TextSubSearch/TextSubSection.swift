//
//  TextSubSection.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxDataSources

struct TextSubSection: Equatable {
    var header: String
    var items: [Item]

    public init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
}

extension TextSubSection: AnimatableSectionModelType {
    typealias Item = String

    var identity: String {
        return header
    }

    init(original: TextSubSection, items: [Item]) {
        self = original
        self.items = items
    }
}
