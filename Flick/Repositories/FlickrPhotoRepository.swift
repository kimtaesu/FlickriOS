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

protocol FlickrPhotoRepositoryType {
//    func search(_ keyword: String, page: Int) -> Single<Resources<PhotoResponse>>
    func geoSearch(_ keyword: String, page: Int, bbox: String) -> Single<Resources<PhotoResponse>>
//    func recent() -> Single<Resources<PhotoResponse>>
//    func interestings() -> Single<Resources<PhotoResponse>>
    func getComments(photoId: String) -> Single<Resources<CommentResponse>>
//    func categories() -> Single<[ListDiffable]>
}

class FlickrPhotoRepository: FlickrPhotoRepositoryType {

    private let provider: MoyaProvider<FlickrApi>

    init(_ provider: MoyaProvider<FlickrApi>) {
        self.provider = provider
    }

//    func categories() -> Single<[ListDiffable]> {
//        return Single.zip(interestings(), recent()) { interesting, recent in
//            var sections: [ListDiffable] = []
//
//            let count: Int = UserDefaults.standard.value(forKey: UserDefaultKeys.categoryCount)
//            let interestingTitle = L10n.interestingSectionHeader
//            interesting.unwrap(do: { response in
//                sections.append(CategoryPhotoSection(header: interestingTitle, items: Array(response.photos.photo.prefix(count))))
//            }, error: { error in
//                sections.append(CategoryPhotoSection(header: interestingTitle, items: [RetryViewModel()]))
//            })
//
//            let recentTitle = L10n.recentSectionHeader
//            recent.unwrap(do: { response in
//                sections.append(CategoryPhotoSection(header: recentTitle, items: Array(response.photos.photo.prefix(count))))
//            }, error: { error in
//                sections.append(CategoryPhotoSection(header: recentTitle, items: [RetryViewModel()]))
//            })
//            return sections
//        }
//    }
    func geoSearch(_ keyword: String, page: Int, bbox: String) -> Single<Resources<PhotoResponse>> {
        return self.provider.rx.request(.geoSearch(FkrGeoSearchReq(text: keyword, page: page, bbox: bbox))).network()

    }
//    func interestings() -> Single<Resources<PhotoResponse>> {
//        return self.provider.rx.request(.interestings(FkrRecentRequest(page: 1))).network()
//    }
//    func recent() -> Single<Resources<PhotoResponse>> {
//        return self.provider.rx.request(.recent(FkrRecentRequest(page: 1))).network()
//    }
//    func search(_ keyword: String, page: Int) -> Single<Resources<PhotoResponse>> {
//        return self.provider.rx.request(.search(FkrSearchRequest(text: keyword, page: page))).network()
//    }
//
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
