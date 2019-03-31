//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import RxSwift
import IGListKit

class CategoryReactor: Reactor {
    
    let initialState = State()
    
    private let repository: FlickrPhotoRepositoryType
    
    init(_ repository: FlickrPhotoRepositoryType) {
        self.repository = repository
    }
    enum Action {
        case fetchData
    }
    
    struct State {
        var initLoading: Bool?
        var items: [RecentItem]?
        var error: Error?
    }
    
    enum Mutation {
        case setInitLoading(Bool)
        case setRecentResults(Resources<PhotoResponse>)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchData:
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
                newState.items = [RecentItem(items: thumbnails)]
            }
            newState.error = result.error
        case .setInitLoading(let loading):
            newState.initLoading = loading
        }
        return newState
    }
}
