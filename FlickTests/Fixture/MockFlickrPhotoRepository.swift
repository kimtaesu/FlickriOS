//
//  MockFlickrPhotoRepository.swift
//  FlickTests
//
//  Created by tskim on 23/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Cuckoo
import RxSwift
@testable import Flick

extension MockFlickrPhotoRepositoryType {
    func mockSimple() {
        stub(self, block: { mock in
            let photoResponse: PhotoResponse = ResourcesLoader.loadJson("simple")
            when(mock.geoSearch(any(), page: any(), bbox: any())).thenReturn(Single.just(Resources.success(photoResponse)))
        })
    }
}
