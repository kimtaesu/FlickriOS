//
//  FlickrRepository.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit
import Moya
import Result
import RxMoya
import RxSwift


class FlickrPhotoRepository: FlickrPhotoRepositoryType {

    private let provider: MoyaProvider<FlickrApi>

    init(_ provider: MoyaProvider<FlickrApi>) {
        self.provider = provider
    }

    func geoSearch(_ keyword: String, page: Int, bbox: String) -> Single<Resources<PhotoResponse>> {
        return self.provider.rx.request(.geoSearch(FkrGeoSearchReq(text: keyword, page: page, bbox: bbox))).network()

    }
    func getComments(photoId: String) -> Single<Resources<CommentResponse>> {
        return self.provider.rx.request(.getComments(FkrCommentRequest(photo_id: photoId))).network()
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, Element == Response {
    func network<T: Decodable>() -> Single<Resources<T>> {
        return filterSuccessfulStatusCodes()
            .map(T.self)
            .map { Resources.success($0) }
            .catchError({ error in
                logger.error(error)
                return Single.just(Resources.error(error))
            })
    }
}
