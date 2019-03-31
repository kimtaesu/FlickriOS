//
//  PagableProtocol.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

protocol HasPagableProtocol {
    var page: Int { get }
    var per_page: Int { get }
}
