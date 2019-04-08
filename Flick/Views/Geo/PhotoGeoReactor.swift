//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import RxSwift

class PhotoGeoReactor: Reactor {

    let initialState = State(photos: [])

    private let repository: FlickrPhotoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType) {
        self.repository = repository
    }
    enum Action {
        case fetchPhotosGeo(String)
    }

    struct State {
        var photos: [Photo]

        public init(photos: [Photo]) {
            self.photos = photos
        }

        var initLoading: Bool?
        var initError: Error?
    }

    enum Mutation {
        case setInitLoading(Bool)
        case setPhotoResult(Resources<PhotoResponse>)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .fetchPhotosGeo(text):
            return Observable.concat([
                Observable.just(Mutation.setInitLoading(true)),
                self.repository.geoSearch(text, page: 1, bbox: "-43.769531,1.230374,47.285156,58.950008").asObservable().map { Mutation.setPhotoResult($0) },
                Observable.just(Mutation.setInitLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(photos: state.photos)
        switch mutation {
        case .setInitLoading(let loading):
            newState.initLoading = loading
        case .setPhotoResult(let response):
            newState.photos = response.data?.photos.photo ?? []
            newState.initError = response.error
        }
        return newState
    }
}
