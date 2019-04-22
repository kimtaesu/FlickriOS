// MARK: - Mocks generated from file: Flick/Repositories/FlickrGeoRepository.swift at 2019-04-17 03:16:12 +0000

//
//  FlickrRepository.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Cuckoo
@testable import Flick

import Foundation
import Moya
import Result
import RxMoya
import RxSwift
import XMLParsing


 class MockFlickrGeoRepositoryType: FlickrGeoRepositoryType, Cuckoo.ProtocolMock {
     typealias MocksType = FlickrGeoRepositoryType
     typealias Stubbing = __StubbingProxy_FlickrGeoRepositoryType
     typealias Verification = __VerificationProxy_FlickrGeoRepositoryType

    private var __defaultImplStub: FlickrGeoRepositoryType?

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

     func enableDefaultImplementation(_ stub: FlickrGeoRepositoryType) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    
    
     func findLocation(_ location: String)  -> Single<Resources<LocationResultSet>> {
        
            return cuckoo_manager.call("findLocation(_: String) -> Single<Resources<LocationResultSet>>",
                parameters: (location),
                escapingParameters: (location),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.findLocation(location))
        
    }
    

	 struct __StubbingProxy_FlickrGeoRepositoryType: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func findLocation<M1: Cuckoo.Matchable>(_ location: M1) -> Cuckoo.ProtocolStubFunction<(String), Single<Resources<LocationResultSet>>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: location) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFlickrGeoRepositoryType.self, method: "findLocation(_: String) -> Single<Resources<LocationResultSet>>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FlickrGeoRepositoryType: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func findLocation<M1: Cuckoo.Matchable>(_ location: M1) -> Cuckoo.__DoNotUse<Single<Resources<LocationResultSet>>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: location) { $0 }]
	        return cuckoo_manager.verify("findLocation(_: String) -> Single<Resources<LocationResultSet>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class FlickrGeoRepositoryTypeStub: FlickrGeoRepositoryType {
    

    

    
     func findLocation(_ location: String)  -> Single<Resources<LocationResultSet>> {
        return DefaultValueRegistry.defaultValue(for: Single<Resources<LocationResultSet>>.self)
    }
    
}



 class MockFlickrGeoRepository: FlickrGeoRepository, Cuckoo.ClassMock {
     typealias MocksType = FlickrGeoRepository
     typealias Stubbing = __StubbingProxy_FlickrGeoRepository
     typealias Verification = __VerificationProxy_FlickrGeoRepository

    private var __defaultImplStub: FlickrGeoRepository?

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

     func enableDefaultImplementation(_ stub: FlickrGeoRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    
    
     override func findLocation(_ location: String)  -> Single<Resources<LocationResultSet>> {
        
            return cuckoo_manager.call("findLocation(_: String) -> Single<Resources<LocationResultSet>>",
                parameters: (location),
                escapingParameters: (location),
                superclassCall:
                    
                    super.findLocation(location)
                    ,
                defaultCall: __defaultImplStub!.findLocation(location))
        
    }
    

	 struct __StubbingProxy_FlickrGeoRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func findLocation<M1: Cuckoo.Matchable>(_ location: M1) -> Cuckoo.ClassStubFunction<(String), Single<Resources<LocationResultSet>>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: location) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFlickrGeoRepository.self, method: "findLocation(_: String) -> Single<Resources<LocationResultSet>>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FlickrGeoRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func findLocation<M1: Cuckoo.Matchable>(_ location: M1) -> Cuckoo.__DoNotUse<Single<Resources<LocationResultSet>>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: location) { $0 }]
	        return cuckoo_manager.verify("findLocation(_: String) -> Single<Resources<LocationResultSet>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class FlickrGeoRepositoryStub: FlickrGeoRepository {
    

    

    
     override func findLocation(_ location: String)  -> Single<Resources<LocationResultSet>> {
        return DefaultValueRegistry.defaultValue(for: Single<Resources<LocationResultSet>>.self)
    }
    
}


// MARK: - Mocks generated from file: Flick/Repositories/FlickrPhotoRepository.swift at 2019-04-17 03:16:12 +0000

//
//  FlickrRepository.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Cuckoo
@testable import Flick

import Foundation
import IGListKit
import Moya
import Result
import RxMoya
import RxSwift


 class MockFlickrPhotoRepositoryType: FlickrPhotoRepositoryType, Cuckoo.ProtocolMock {
     typealias MocksType = FlickrPhotoRepositoryType
     typealias Stubbing = __StubbingProxy_FlickrPhotoRepositoryType
     typealias Verification = __VerificationProxy_FlickrPhotoRepositoryType

    private var __defaultImplStub: FlickrPhotoRepositoryType?

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

     func enableDefaultImplementation(_ stub: FlickrPhotoRepositoryType) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    
    
     func geoSearch(_ keyword: String, page: Int, bbox: String)  -> Single<Resources<PhotoResponse>> {
        
            return cuckoo_manager.call("geoSearch(_: String, page: Int, bbox: String) -> Single<Resources<PhotoResponse>>",
                parameters: (keyword, page, bbox),
                escapingParameters: (keyword, page, bbox),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.geoSearch(keyword, page: page, bbox: bbox))
        
    }
    
    
    
     func getComments(photoId: String)  -> Single<Resources<CommentResponse>> {
        
            return cuckoo_manager.call("getComments(photoId: String) -> Single<Resources<CommentResponse>>",
                parameters: (photoId),
                escapingParameters: (photoId),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.getComments(photoId: photoId))
        
    }
    

	 struct __StubbingProxy_FlickrPhotoRepositoryType: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func geoSearch<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ keyword: M1, page: M2, bbox: M3) -> Cuckoo.ProtocolStubFunction<(String, Int, String), Single<Resources<PhotoResponse>>> where M1.MatchedType == String, M2.MatchedType == Int, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int, String)>] = [wrap(matchable: keyword) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: bbox) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFlickrPhotoRepositoryType.self, method: "geoSearch(_: String, page: Int, bbox: String) -> Single<Resources<PhotoResponse>>", parameterMatchers: matchers))
	    }
	    
	    func getComments<M1: Cuckoo.Matchable>(photoId: M1) -> Cuckoo.ProtocolStubFunction<(String), Single<Resources<CommentResponse>>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: photoId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFlickrPhotoRepositoryType.self, method: "getComments(photoId: String) -> Single<Resources<CommentResponse>>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FlickrPhotoRepositoryType: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func geoSearch<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ keyword: M1, page: M2, bbox: M3) -> Cuckoo.__DoNotUse<Single<Resources<PhotoResponse>>> where M1.MatchedType == String, M2.MatchedType == Int, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int, String)>] = [wrap(matchable: keyword) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: bbox) { $0.2 }]
	        return cuckoo_manager.verify("geoSearch(_: String, page: Int, bbox: String) -> Single<Resources<PhotoResponse>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getComments<M1: Cuckoo.Matchable>(photoId: M1) -> Cuckoo.__DoNotUse<Single<Resources<CommentResponse>>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: photoId) { $0 }]
	        return cuckoo_manager.verify("getComments(photoId: String) -> Single<Resources<CommentResponse>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class FlickrPhotoRepositoryTypeStub: FlickrPhotoRepositoryType {
    

    

    
     func geoSearch(_ keyword: String, page: Int, bbox: String)  -> Single<Resources<PhotoResponse>> {
        return DefaultValueRegistry.defaultValue(for: Single<Resources<PhotoResponse>>.self)
    }
    
     func getComments(photoId: String)  -> Single<Resources<CommentResponse>> {
        return DefaultValueRegistry.defaultValue(for: Single<Resources<CommentResponse>>.self)
    }
    
}



 class MockFlickrPhotoRepository: FlickrPhotoRepository, Cuckoo.ClassMock {
     typealias MocksType = FlickrPhotoRepository
     typealias Stubbing = __StubbingProxy_FlickrPhotoRepository
     typealias Verification = __VerificationProxy_FlickrPhotoRepository

    private var __defaultImplStub: FlickrPhotoRepository?

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

     func enableDefaultImplementation(_ stub: FlickrPhotoRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    
    
     override func geoSearch(_ keyword: String, page: Int, bbox: String)  -> Single<Resources<PhotoResponse>> {
        
            return cuckoo_manager.call("geoSearch(_: String, page: Int, bbox: String) -> Single<Resources<PhotoResponse>>",
                parameters: (keyword, page, bbox),
                escapingParameters: (keyword, page, bbox),
                superclassCall:
                    
                    super.geoSearch(keyword, page: page, bbox: bbox)
                    ,
                defaultCall: __defaultImplStub!.geoSearch(keyword, page: page, bbox: bbox))
        
    }
    
    
    
     override func getComments(photoId: String)  -> Single<Resources<CommentResponse>> {
        
            return cuckoo_manager.call("getComments(photoId: String) -> Single<Resources<CommentResponse>>",
                parameters: (photoId),
                escapingParameters: (photoId),
                superclassCall:
                    
                    super.getComments(photoId: photoId)
                    ,
                defaultCall: __defaultImplStub!.getComments(photoId: photoId))
        
    }
    

	 struct __StubbingProxy_FlickrPhotoRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func geoSearch<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ keyword: M1, page: M2, bbox: M3) -> Cuckoo.ClassStubFunction<(String, Int, String), Single<Resources<PhotoResponse>>> where M1.MatchedType == String, M2.MatchedType == Int, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int, String)>] = [wrap(matchable: keyword) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: bbox) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFlickrPhotoRepository.self, method: "geoSearch(_: String, page: Int, bbox: String) -> Single<Resources<PhotoResponse>>", parameterMatchers: matchers))
	    }
	    
	    func getComments<M1: Cuckoo.Matchable>(photoId: M1) -> Cuckoo.ClassStubFunction<(String), Single<Resources<CommentResponse>>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: photoId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFlickrPhotoRepository.self, method: "getComments(photoId: String) -> Single<Resources<CommentResponse>>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FlickrPhotoRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func geoSearch<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ keyword: M1, page: M2, bbox: M3) -> Cuckoo.__DoNotUse<Single<Resources<PhotoResponse>>> where M1.MatchedType == String, M2.MatchedType == Int, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int, String)>] = [wrap(matchable: keyword) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: bbox) { $0.2 }]
	        return cuckoo_manager.verify("geoSearch(_: String, page: Int, bbox: String) -> Single<Resources<PhotoResponse>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getComments<M1: Cuckoo.Matchable>(photoId: M1) -> Cuckoo.__DoNotUse<Single<Resources<CommentResponse>>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: photoId) { $0 }]
	        return cuckoo_manager.verify("getComments(photoId: String) -> Single<Resources<CommentResponse>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class FlickrPhotoRepositoryStub: FlickrPhotoRepository {
    

    

    
     override func geoSearch(_ keyword: String, page: Int, bbox: String)  -> Single<Resources<PhotoResponse>> {
        return DefaultValueRegistry.defaultValue(for: Single<Resources<PhotoResponse>>.self)
    }
    
     override func getComments(photoId: String)  -> Single<Resources<CommentResponse>> {
        return DefaultValueRegistry.defaultValue(for: Single<Resources<CommentResponse>>.self)
    }
    
}

