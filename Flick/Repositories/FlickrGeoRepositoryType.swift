//
//  FlickrGeoRepositoryType.swift
//  Flick
//
//  Created by tskim on 22/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

protocol FlickrGeoRepositoryType {
    func findLocation(_ location: String) -> Single<Resources<LocationResultSet>>
}
