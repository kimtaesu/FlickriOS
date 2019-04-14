//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
// https://dribbble.com/shots/3328958-Photo-Search-Interaction

import ReactorKit
import RxSwift

class SearchReactor: Reactor {

    var initialState: State

    private let repository: FlickrPhotoRepositoryType
    private let geoRepository: FlickrGeoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType, geo: FlickrGeoRepositoryType, searchItems: [SearchOption]) {
        self.geoRepository = geo
        self.repository = repository
        initialState = State(text: "", bbox: Enviroment.WORLD_BBOX, searchItems: searchItems)
        initialState.searchSections = [GeoSearchOptionSection(header: "geo", items: searchItems)
        ]
    }

    enum Action {
        case setText(String?)
        case setLocation(LocationResult)
        case setSearch
        case tapsSearchOption(Int)
    }

    struct State {
        var text: String
        var bbox: String
        var searchItems: [SearchOption]

        public init(text: String, bbox: String, searchItems: [SearchOption]) {
            self.text = text
            self.bbox = bbox
            self.searchItems = searchItems
        }

        var photos: [Photo]?
        var tapsSearchOption: SearchOption?
        var searchSections: [GeoSearchOptionSection]?
        var loading: Bool?
        var locationLoading: Bool?
        var error: Error?
    }

    enum Mutation {
        case setLoading(Bool)
        case setSearchResults(Resources<PhotoResponse>)
        case setText(String)
        case setLocation(LocationResult)
        
        case setLocationLoading(Bool)
        case tapsSearchOption(Int)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapsSearchOption(let index):
            return .just(Mutation.tapsSearchOption(index))
        case .setSearch:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                self.repository.geoSearch(currentState.text, page: 1, bbox: currentState.bbox).asObservable().map { Mutation.setSearchResults($0) },
                Observable.just(Mutation.setLoading(false))
                ])
        case .setLocation(let result):
            return .just(Mutation.setLocation(result))
        case .setText(let text):
            guard let text = text, text.isNotEmpty else { return .empty() }
            return Observable.just(Mutation.setText(text))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(text: state.text, bbox: state.bbox, searchItems: state.searchItems)
        switch mutation {
        case .tapsSearchOption(let index):
            newState.tapsSearchOption = newState.searchItems[index]
        case .setText(let text):
            newState.text = text
            newState.searchItems[SearchAction.text.rawValue].message = text
            newState.searchSections = [GeoSearchOptionSection(header: "geo", items: newState.searchItems)]
        case .setLocation(let result):
            newState.bbox = result.bbox
            newState.searchItems[SearchAction.location.rawValue].message = result.label ?? L10n.geoSearchOptionsLocationMessage
            newState.searchSections = [GeoSearchOptionSection(header: "geo", items: newState.searchItems)]
        case .setLoading(let loading):
            newState.loading = loading
        case .setLocationLoading(let loading):
            newState.locationLoading = loading
        case .setSearchResults(let result):
            newState.photos = result.data?.photos.photo
            newState.error = result.error
        }
        return newState
    }
}
