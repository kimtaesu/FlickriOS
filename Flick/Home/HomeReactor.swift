//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import RxSwift

class HomeReactor: Reactor {

    let initialState = State()

    private let repository: FlickrRepositoryType

    init(_ repository: FlickrRepositoryType) {
        self.repository = repository
    }
    enum Action {
        case search(String)
    }

    struct State {
        var initLoading: Bool?
        var reponse: FkrSearchResponse?
        var error: Error?
    }

    enum Mutation {
        case setInitLoading(Bool)
        case setSearchResults(Resources<FkrSearchResponse>)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .search(let keyword):
            return Observable.concat([
                Observable.just(Mutation.setInitLoading(true)),
                self.repository.search(keyword).asObservable().map { Mutation.setSearchResults($0) },
                Observable.just(Mutation.setInitLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSearchResults(let result):
            newState.reponse = result.data
            newState.error = result.error
        case .setInitLoading(let loading):
            newState.initLoading = loading
        }
        return newState
    }
}
