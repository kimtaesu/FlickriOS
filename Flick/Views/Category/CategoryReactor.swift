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
        InterestingSection(header: "Interestings", items: LoadingThumbnailViewModel.generateThumbnails(5)),
        RecentSection(header: "Recent", items: LoadingThumbnailViewModel.generateThumbnails(5))
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

        var initLoading: Bool?

        var recentError: Error?
        var interestingError: Error?
    }

    enum Mutation {
        case setInitLoading(Bool)
        case setResults(String, Resources<PhotoResponse>)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchInteresting:
            return Observable.concat([
                Observable.just(Mutation.setInitLoading(true)),
                self.repository.interestings().asObservable().map { Mutation.setResults("Interestings", $0) },
                Observable.just(Mutation.setInitLoading(false))
                ])
        case .fetchRecent:
            return Observable.concat([
                Observable.just(Mutation.setInitLoading(true)),
                self.repository.recent().asObservable().map { Mutation.setResults("Recent", $0) },
                Observable.just(Mutation.setInitLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(items: state.items)
        switch mutation {
        case let .setResults(header, result):
            switch header {
            case "Interestings":
                let interestingSection = newState.items.first { section in
                    section is InterestingSection
                }
                if let interestingSection = interestingSection as? InterestingSection,
                    let data = result.data?.photos.photo {
                    interestingSection.items = data
                }
                newState.interestingError = result.error
            case "Recent":
                let interestingSection = newState.items.first { section in
                    section is RecentSection
                }
                if let interestingSection = interestingSection as? InterestingSection,
                    let data = result.data?.photos.photo {
                    interestingSection.items = data
                }
                newState.recentError = result.error
            default:
                break
            }
        case .setInitLoading(let loading):
            newState.initLoading = loading
        }
        return newState
    }
}
