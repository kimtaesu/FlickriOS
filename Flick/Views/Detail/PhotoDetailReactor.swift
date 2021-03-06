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

class PhotoDetailReactor: Reactor {

    let initialState: State

    private let repository: FlickrPhotoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType, photo: Photo) {
        self.repository = repository
        self.initialState = State(photo: photo, likesViewModes: [])
    }

    enum Action {
        case setLoadView(CGSize)
        case setLoadComments
    }

    struct State {
        let photo: Photo
        let likesViewModes: [LikesViewModel]

        public init(photo: Photo, likesViewModes: [LikesViewModel]) {
            self.photo = photo
            self.likesViewModes = [
                LikesViewModel(type: .likes, count: photo.countLikes, image: Asset.icThumbUp.image),
                LikesViewModel(type: .views, count: photo.views, image: Asset.icViews.image),
                LikesViewModel(type: .comments, count: photo.countComments, image: Asset.icComments.image)
            ]
        }

        var dateTaken: String?
        var ownerName: String?
        var buddyIcon: URL?
        var title: String?
        var desc: String?
        var detailImage: URL?
        var imageSource: ImageSource?
        var initLoading: Bool?
        var error: Error?
        var licenseCount: String?
        var commentLoading: Bool?
        var commentError: Error?
        var comments: [Comment]?
        var location: CLLocationCoordinate2D?
    }

    enum Mutation {
        case setInitLoading(Bool)
        case setLoadView(CGSize)
        case setLoadingComment(Bool)
        case setCommentResults(Resources<CommentResponse>)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setLoadComments:
            return Observable.concat([
                Observable.just(Mutation.setLoadingComment(true)),
//                self.repository.getComments(photoId: photo.id).asObservable().map { Mutation.setCommentResults($0) },
                Observable.just(Mutation.setLoadingComment(false))
                ])
        case .setLoadView(let preferViewSize):
            return Observable.just(Mutation.setLoadView(preferViewSize))
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(photo: state.photo, likesViewModes: state.likesViewModes)
        switch mutation {
        case .setCommentResults(let result):
            newState.comments = result.data?.comments.comment
            newState.commentError = result.error
        case .setInitLoading(let loading):
            newState.initLoading = loading
        case .setLoadingComment(let loading):
            newState.commentLoading = loading
        case .setLoadView(let preferViewSize):
            if let imageSource = self.photo.nearHeightByWidth(width: Int(preferViewSize.width)),
                let imageUrl = URL(string: imageSource.imageUrl) {
                newState.detailImage = imageUrl
            }

            newState.licenseCount = L10n.licenseCount(photo.license ?? "")
            newState.buddyIcon = URL(string: photo.iconBuddy)
            newState.title = photo.title
            newState.desc = photo.description?.first?.value
            newState.ownerName = photo.ownername
            newState.dateTaken = photo.datetaken?.toDateFormat(outputFormat: L10n.dateFormatAtPhotoTaken)
        }

        return newState
    }
}

extension PhotoDetailReactor {
    var photo: Photo {
        return currentState.photo
    }
}
