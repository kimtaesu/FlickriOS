//
//  Photo+FindResolution.swift
//  FlickTests
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Nimble
import Quick
@testable import Flick
class PhotoFindResolutionTest: QuickSpec {

    
    private let photo = Photo(id: "", owner: "", secret: "", title: "", ispublic: 0, isfriend: 0, isfamily: 0, dateupload: "", lastupdate: "", datetaken: "", ownername: "", views: "", machine_tags: "", originalsecret: "", originalformat: "", latitude: 0, longitude: 0, accuracy: 0, media: "", media_status: "", imageSources: [
        ImageSource(imageUrl: "", width: 120, height: 120),
        ImageSource(imageUrl: "", width: 123, height: 123),
        ImageSource(imageUrl: "", width: 124, height: 124)
        ])
    override func spec() {
        describe("PhotoFindResolutionTest") {
            it("find resolution", closure: {
                let actual = self.photo.findResolutionByWidth(width: 122)
                expect(actual) == ImageSource(imageUrl: "", width: 123, height: 123)
            })
        }
    }
}
