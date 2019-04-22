//
//  FlickrPhotoRepositoryType.swift
//  Flick
//
//  Created by tskim on 22/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import RxSwift

protocol FlickrPhotoRepositoryType {
    func geoSearch(_ keyword: String, page: Int, bbox: String) -> Single<Resources<PhotoResponse>>
    func getComments(photoId: String) -> Single<Resources<CommentResponse>>
}
