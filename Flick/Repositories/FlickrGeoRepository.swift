//
//  FlickrRepository.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Moya
import Result
import RxMoya
import RxSwift
import XMLParsing

protocol FlickrGeoRepositoryType {
    func findLocation(_ location: String) -> Single<Resources<LocationResultSet>>
}

class FlickrGeoRepository: FlickrGeoRepositoryType {
    private let provider: MoyaProvider<FlickrApi>
    
    init(_ provider: MoyaProvider<FlickrApi>) {
        self.provider = provider
    }
    func findLocation(_ location: String) -> Single<Resources<LocationResultSet>> {
        return self.provider.rx.request(.findLocation(location))
            .filterSuccessfulStatusCodes()
            .map { try XMLDecoder().decode(LocationResultSet.self, from: $0.data) }
            .map { Resources.success($0) }
            .catchError({ error in
                logger.error(error)
                return Single.just(Resources.error(error))
            })
    }
}
