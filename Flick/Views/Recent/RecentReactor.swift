//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import RxSwift

class RecentReactor: Reactor {

    let initialState = State()

    private let repository: FlickrPhotoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType) {
        self.repository = repository
    }
    enum Action {
        case recent
    }

    struct State {
        var initLoading: Bool?
        var thumbnails: [ThumbnailSection]?
        var error: Error?
    }

    enum Mutation {
        case setInitLoading(Bool)
        case setRecentResults(Resources<PhotoResponse>)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .recent:
            return Observable.concat([
                Observable.just(Mutation.setInitLoading(true)),
                self.repository.recent().asObservable().map { Mutation.setRecentResults($0) },
                Observable.just(Mutation.setInitLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setRecentResults(let result):
            if let thumbnails = result.data?.mapThumbnail(width: 400) {
                newState.thumbnails = [ThumbnailSection(header: "Thumbnails", items: thumbnails)]
            }
            newState.error = result.error
        case .setInitLoading(let loading):
            newState.initLoading = loading
        }
        return newState
    }
}
