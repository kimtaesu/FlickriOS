//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import RxSwift
import UIKit

class PhotoDetailReactor: Reactor {

    let photo: Photo
    let initialState = State()

    private let repository: FlickrPhotoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType, photo: Photo) {
        self.photo = photo
        self.repository = repository
    }

    enum Action {
        case setLoadImageView(CGSize)
        case setInitView
        case loadComment
    }

    struct State {
        var title: String?
        var desc: String?
        var detailImage: URL?
        var imageSource: ImageSource?
        var initLoading: Bool?
        var error: Error?
        
        var commentLoading: Bool?
        var commentError: Error?
        var comments: [Comment]?
    }

    enum Mutation {
        case setInitView
        case setInitLoading(Bool)
        case setImageUrl(URL)
        
        case setLoadingComment(Bool)
        case setCommentResults(Resources<CommentResponse>)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadComment:
            return Observable.concat([
                Observable.just(Mutation.setLoadingComment(true)),
                self.repository.getComments(photoId: photo.id).asObservable().map { Mutation.setCommentResults($0) },
                Observable.just(Mutation.setLoadingComment(false))
                ])
        case .setInitView:
            return Observable.just(Mutation.setInitView)
        case let .setLoadImageView(viewSize):
            guard let imageSource = self.photo.findResolutionByWidth(width: Int(viewSize.width)),
                let imageUrl = URL(string: imageSource.imageUrl) else { return .empty() }
            return Observable.just(Mutation.setImageUrl(imageUrl))
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State()
        switch mutation {
        case .setCommentResults(let result):
            newState.comments = result.data?.comments.comment
            newState.commentError = result.error
        case .setImageUrl(let image):
            newState.detailImage = image
        case .setInitView:
            newState.title = photo.title
            newState.desc = photo.description.first?.value
        case .setInitLoading(let loading):
            newState.initLoading = loading
        case .setLoadingComment(let loading):
            newState.commentLoading = loading
        }

        return newState
    }
}
