//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import RxSwift

class SearchReactor: Reactor {
    
    let initialState = State(text: "")
    
    private let repository: FlickrPhotoRepositoryType
    
    init(_ repository: FlickrPhotoRepositoryType) {
        self.repository = repository
    }
    enum Action {
        case setText(String)
        case search
    }
    
    struct State {
        var text: String

        public init(text: String) {
            self.text = text
        }
        
        var showKeyboard: Bool?
        var initLoading: Bool?
        var thumbnails: [PhotoSection]?
        var error: Error?
    }
    
    enum Mutation {
        case setInitLoading(Bool)
        case setSearchResults(Resources<PhotoResponse>)
        case setText(String)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setText(let text):
            return Observable.just(Mutation.setText(text))
            
        case .search:
            if currentState.text.isNotEmpty {
                return Observable.concat([
                    Observable.just(Mutation.setInitLoading(true)),
                    self.repository.search(currentState.text, page: 1).asObservable().map { Mutation.setSearchResults($0) },
                    Observable.just(Mutation.setInitLoading(false))
                    ])
            } else {
                return .empty()
            }
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(text: currentState.text)
        switch mutation {
        case .setText(let text):
            newState.text = text
        case .setSearchResults(let result):
            if let photos = result.data?.photos.photo {
                newState.thumbnails = [PhotoSection(header: "Thumbnails", items: photos)]
            }
            newState.error = result.error
            newState.showKeyboard = false
        case .setInitLoading(let loading):
            newState.initLoading = loading
        }
        return newState
    }
}
