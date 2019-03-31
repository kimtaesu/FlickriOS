//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import RxSwift

class CategoryReactor: Reactor {
    
    let initialState = State()
    
    private let repository: FlickrPhotoRepositoryType
    
    init(_ repository: FlickrPhotoRepositoryType) {
        self.repository = repository
    }
    enum Action {
        case search(String)
    }
    
    struct State {
        var initLoading: Bool?
        var searchResults: [ThumbnailSection]?
        var error: Error?
    }
    
    enum Mutation {
        case setInitLoading(Bool)
        case setSearchedResults(Resources<PhotoResponse>)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .search(let keyword):
            return Observable.concat([
                Observable.just(Mutation.setInitLoading(true)),
                self.repository.search(keyword, page: 1).asObservable().map { Mutation.setSearchedResults($0) },
                Observable.just(Mutation.setInitLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSearchedResults(let result):
            if let thumbnails = result.data?.mapThumbnail(width: 400) {
                newState.searchResults = [ThumbnailSection(header: "Thumbnails", items: thumbnails)]
            }
            newState.error = result.error
        case .setInitLoading(let loading):
            newState.initLoading = loading
        }
        return newState
    }
}
