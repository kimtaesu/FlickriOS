//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import IGListKit
import ReactorKit
import RxSwift

class CategoryReactor: Reactor {

    let initialState = State(items: [
        CategoryPhotoSection(header: L10n.interestingSectionHeader, items: LoadingViewModel.generateThumbnails(5)),
        CategoryPhotoSection(header: L10n.recentSectionHeader, items: LoadingViewModel.generateThumbnails(5))
        ])

    private let repository: FlickrPhotoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType) {
        self.repository = repository
    }
    enum Action {
        case fetchRecent
        case fetchInteresting
    }

    struct State {
        var items: [ListDiffable]
        
        public init(items: [ListDiffable]) {
            self.items = items
        }
        var photos: [Photo]?
        
        var initLoading: Bool?

        var recentError: Error?
        var interestingError: Error?
    }

    enum Mutation {
        case setInitLoading(Bool)
        case setPhotoResult(Resources<PhotoResponse>)
        case setResults([ListDiffable])
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchInteresting:
            return Observable.concat([
                Observable.just(Mutation.setInitLoading(true)),
                self.repository.interestings().asObservable().map { Mutation.setPhotoResult($0) },
                Observable.just(Mutation.setInitLoading(false))
                ])
        case .fetchRecent:
            return .empty()
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(items: state.items)
        switch mutation {
        case let .setResults(results):
            newState.items = results
        case .setInitLoading(let loading):
            newState.initLoading = loading
        case .setPhotoResult(let reponse):
            newState.photos = reponse.data?.photos.photo
        }
        return newState
    }
}
