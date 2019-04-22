import MapKit
import ReactorKit
import RxSwift
import UIKit

class DetailReactor: Reactor {

    let initialState: State

    private let repository: FlickrPhotoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType, photo: Photo) {
        self.repository = repository
        self.initialState = State(photo: photo)
    }

    enum Action {
        case setLoadView
    }

    struct State {
        let photo: Photo

        public init(photo: Photo) {
            self.photo = photo
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
        case setLoadView
        case setCommentResults(Resources<CommentResponse>)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setLoadView:
            return Observable.just(Mutation.setLoadView)
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(photo: state.photo)
        switch mutation {
        case .setCommentResults(let result):
            newState.comments = result.data?.comments.comment
            newState.commentError = result.error
        case .setLoadView:
            break
        }
        return newState
    }
}
