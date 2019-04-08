//
//  Photo+Ident.swift
//  Flick
//
//  Created by tskim on 01/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxDataSources

extension Photo: IdentifiableType {
    typealias Identity = String
    
    var identity: String {
        return self.id
    }
}
