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

protocol FlickrPhotoRepositoryType {
    func search(_ keyword: String, page: Int) -> Single<Resources<PhotoResponse>>
    func recent() -> Single<Resources<PhotoResponse>>
    func getComments(photoId: String) -> Single<Resources<PhotoResponse>>
}

class FlickrPhotoRepository: FlickrPhotoRepositoryType {
    private let provider: MoyaProvider<FlickrApi>

    init(_ provider: MoyaProvider<FlickrApi>) {
        self.provider = provider
    }

    func search(_ keyword: String, page: Int) -> Single<Resources<PhotoResponse>> {
        return self.provider.rx.request(.search(FkrSearchRequest(text: keyword, page: page))).network()
    }
    
    func getComments(photoId: String) -> Single<Resources<PhotoResponse>> {
        return self.provider.rx.request(.getComments(FkrCommentRequest(photo_id: photoId))).network()
    }
    func recent() -> Single<Resources<PhotoResponse>> {
        return self.provider.rx.request(.recent(FkrRecentRequest(page: 1))).network()
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, Element == Response {
    func network<T: Decodable>() -> Single<Resources<T>> {
        return filterSuccessfulStatusCodes()
            .map(T.self)
            .map { Resources.success($0) }
            .catchError({ error  in
                logger.error(error)
                return Single.just(Resources.error(error))
            })
    }
}
