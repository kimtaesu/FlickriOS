//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import MapKit
import ReactorKit
import RxSwift

class PhotoGeoReactor: Reactor {

    let initialState: State

    init() {
        initialState = State()
    }
    enum Action {
        case setPhotos([Photo])
    }

    struct State {
        var annotations: [PhotoAnnotation]

        public init() {
            self.annotations = []
        }
        
        var selectedAnnotation: PhotoAnnotation?
    }

    enum Mutation {
    }

    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State()
        return newState
    }
}
