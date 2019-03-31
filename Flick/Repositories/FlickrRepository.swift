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

protocol FlickrRepositoryType {
    func search(_ keyword: String) -> Single<Resources<FkrSearchResponse>>
}

class FlickrRepository: FlickrRepositoryType {

    private let provider: MoyaProvider<FlickrApi>

    init(_ provider: MoyaProvider<FlickrApi>) {
        self.provider = provider
    }

    func search(_ keyword: String) -> Single<Resources<FkrSearchResponse>> {
        return self.provider.rx.request(.search(FkrSearchRequest(text: keyword, page: 1))).network()
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, Element == Response {
    func network<T: Decodable>() -> Single<Resources<T>> {
        return filterSuccessfulStatusCodes()
            .map(T.self)
            .map { Resources.success($0) }
            .catchError({ error  in
                Single.just(Resources.error(error))
            })
    }
}
