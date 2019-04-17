//
//  PhotoGeoReactorTest.swift
//  FlickTests
//
//  Created by tskim on 15/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Nimble
import Quick
import RxExpect
import RxSwift
import RxTest
@testable import Flick
class PhotoGeoReactorTest: QuickSpec {
    override func spec() {
        
        var reactor: PhotoGeoReactor!
        var repository: FlickrPhotoRepositoryType!
        
        beforeEach {
            repository = MockFlickrPhotoRepositoryType()
            reactor = PhotoGeoReactor(repository)
        }
        
        describe("PhotoGeoReactorTest") {
            it("test", closure: {
                let test = RxExpect()
                let reactor = test.retain(reactor)
                test.input(reactor.action, [
                    next(200, .search("a"))
                    ])
            })
        }
    }
}

