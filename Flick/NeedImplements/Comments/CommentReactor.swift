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
import UIKit

class CommentReactor: Reactor {

    let initialState: State

    private let repository: FlickrPhotoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType, photoId: String) {
        self.repository = repository
        self.initialState = State(photoId: photoId, comments: [])
    }

    enum Action {
        case setLoadComments
    }

    struct State {
        let photoId: String
        var comments: [Comment]

        public init(photoId: String, comments: [Comment]) {
            self.photoId = photoId
            self.comments = comments
        }
        
        var commentSections: [CommentSection]?
        var loading: Bool?
        var error: Error?
    }

    enum Mutation {
        case setLoadingComment(Bool)
        case setCommentResults(Resources<CommentResponse>)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setLoadComments:
            return Observable.concat([
                Observable.just(Mutation.setLoadingComment(true)),
                self.repository.getComments(photoId: currentState.photoId).asObservable().map { Mutation.setCommentResults($0) },
                Observable.just(Mutation.setLoadingComment(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(photoId: state.photoId, comments: state.comments)
        switch mutation {
        case .setCommentResults(let result):
            newState.comments = result.data?.comments.comment ?? []
            newState.commentSections = [CommentSection(header: "Comments", items: newState.comments)]
            newState.error = result.error
        case .setLoadingComment(let loading):
            
            newState.loading = loading
            return newState
        }
        return newState
    }
}
