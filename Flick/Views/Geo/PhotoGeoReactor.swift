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

    let initialState = State(text: "", bbox: Enviroment.WORLD_BBOX, photoSections: [])

    private let repository: FlickrPhotoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType) {
        self.repository = repository
    }
    enum Action {
        case setSearch
    }

    struct State {
        var text: String
        var bbox: String
        var photoSections: [PhotoSection]

        public init(text: String, bbox: String, photoSections: [PhotoSection]) {
            self.text = text
            self.bbox = bbox
            self.photoSections = photoSections
        }
        
        var initLoading: Bool?
        var initError: Error?
    }

    enum Mutation {
        case setInitLoading(Bool)
        case setSearchResults(Resources<PhotoResponse>)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setSearch:
            return Observable.concat([
                Observable.just(Mutation.setInitLoading(true)),
                self.repository.geoSearch(currentState.text, page: 1, bbox: currentState.bbox).asObservable().map { Mutation.setSearchResults($0) },
                Observable.just(Mutation.setInitLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(text: state.text, bbox: state.bbox, photoSections: state.photoSections)
        switch mutation {
        case .setInitLoading(let loading):
            newState.initLoading = loading
        case .setSearchResults(let response):
            newState.photoSections = [PhotoSection(header: "photos", items: response.data?.photos.photo ?? [])]
            newState.initError = response.error
        }
        return newState
    }
}
