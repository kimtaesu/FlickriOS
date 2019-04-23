////
////  PhotoSlideReactorSpec.swift
////  FlickTests
////
////  Created by tskim on 23/04/2019.
////  Copyright © 2019 hucet. All rights reserved.
////
//
//import Foundation
//import Nimble
//import Quick
//import Cuckoo
//import Then
//import RxTest
//@testable import Flick
//class PhotoSlideReactorSpec: QuickSpec {
//    override func spec() {
//        var scheduler: TestScheduler!
//        var reactor: PhotoSlideReactor!
//        var repository: MockFlickrPhotoRepositoryType!
//        beforeEach {
//            scheduler = TestScheduler(initialClock: 0)
//            repository = MockFlickrPhotoRepositoryType()
//            repository.mockSimple()
//            reactor = PhotoSlideReactor(repository)
//        }
//        describe("A PhotoSlideReactorSpec") {
//            it("fetches a photos") {
//                let observable = scheduler.createHotObservable([
//                    next(100, true)
//                    ]).asObservable()
//
//                let results = scheduler.createObserver(Bool)
//
//                // Act
//                scheduler.scheduleAt(50) { subscription
//                    = observable.subscribe(results) }
//                scheduler.scheduleAt(600) { subscription.dispose() }
//                scheduler.start()
//
//                scheduler.start()
//
////                expect(reactor.currentState.isLoadingNextPage) == true
//            }
//        }
//    }
//}
