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

    private let repository: FlickrPhotoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType) {
        self.repository = repository
        initialState = State(text: "", bbox: Enviroment.WORLD_BBOX, photos: [], mapAnnotations: [], nextPage: 1, isLoadingNextPage: false)
    }
    enum Action {
        case setSearch(FkrGeoSearchReq?)
        case tapsPhoto(Int)
        case tapsAnnotationView(MKAnnotation?)
        case toRight
        case toLeft
    }

    struct State {
        var text: String
        var bbox: String
        var photos: [Photo]
        var mapAnnotations: [PhotoAnnotation]
        var nextPage: Int
        var startIndex: Int = 0
        var endIndex: Int = 0
        var isLoadingNextPage: Bool

        public init(text: String, bbox: String, photos: [Photo], mapAnnotations: [PhotoAnnotation], nextPage: Int, startIndex: Int = 0, endIndex: Int = 0, isLoadingNextPage: Bool) {
            self.text = text
            self.bbox = bbox
            self.photos = photos
            self.mapAnnotations = mapAnnotations
            self.nextPage = nextPage
            self.startIndex = startIndex
            self.endIndex = endIndex
            self.isLoadingNextPage = isLoadingNextPage
        }

        let stride: Int = UserDefaults.standard.value(forKey: UserDefaultKeys.photoStride)

        var enabledRight: Bool?
        var enabledLeft: Bool?
        var refreshed: Bool?
        var photoSections: [PhotoSection]?
        var selectedPhoto: Photo?
        var initLoading: Bool?
        var initError: Error?
        var selectedAnnotation: PhotoAnnotation?
    }

    enum Mutation {
        case setInitLoading(Bool)
        case setSearchResultForRight(Resources<PhotoResponse>)
        case tapsPhoto(Photo)
        case tapsAnnotationView(PhotoAnnotation)
        case setLoadingNextPage(Bool)
        case setToLeft
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .toLeft:
            return .just(Mutation.setToLeft)
        case .toRight:
            guard !currentState.isLoadingNextPage else { return .empty() }
            return Observable.concat([
                .just(Mutation.setLoadingNextPage(true)),
                self.repository.geoSearch(currentState.text, page: currentState.nextPage, bbox: currentState.bbox).asObservable().map { Mutation.setSearchResultForRight($0) },
                .just(Mutation.setLoadingNextPage(false))
                ])
        case .tapsAnnotationView(let annotation):
            guard let annotation = annotation as? PhotoAnnotation else { return .empty() }
            return Observable.just(Mutation.tapsAnnotationView(annotation))
        case .tapsPhoto(let index):
            return Observable.just(Mutation.tapsPhoto(currentState.photos[currentState.startIndex + index]))
        case .setSearch:
            return Observable.concat([
                .just(Mutation.setInitLoading(true)),
                self.repository.geoSearch(currentState.text, page: 1, bbox: currentState.bbox).asObservable().map { Mutation.setSearchResultForRight($0) },
                .just(Mutation.setInitLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(text: state.text, bbox: state.bbox, photos: state.photos, mapAnnotations: state.mapAnnotations, nextPage: state.nextPage, startIndex: state.startIndex, endIndex: state.endIndex, isLoadingNextPage: state.isLoadingNextPage)

        switch mutation {
        case .setToLeft:
            newState.endIndex = max(newState.stride, newState.startIndex)
            newState.startIndex = max(0, newState.startIndex - newState.stride)
            let slice = newState.photos[newState.startIndex..<newState.endIndex]
            let stagingPhotos = slice.compactMap { $0 }
            newState.photoSections = [PhotoSection(header: "photos", items: stagingPhotos)]
            newState.enabledLeft = !isFirstPage(startIndex: newState.startIndex)
            newState.mapAnnotations = stagingPhotos.map { PhotoAnnotation(photo: $0) }
        case .tapsAnnotationView(let annotation):
            newState.selectedAnnotation = annotation
        case .tapsPhoto(let photo):
            newState.selectedPhoto = photo
        case .setLoadingNextPage(let loading):
            newState.isLoadingNextPage = loading
        case .setInitLoading(let loading):
            newState.initLoading = loading
        case .setSearchResultForRight(let response):
            if let error = response.error {
                newState.initError = error
            } else {
                let photos = response.data?.photos.photo ?? []
                newState.photos += photos
                newState.startIndex = newState.endIndex
                newState.endIndex = min(newState.photos.count, newState.endIndex + newState.stride)
                let slice = newState.photos[newState.startIndex..<newState.endIndex]
                let stagingPhotos = slice.compactMap { $0 }
                newState.mapAnnotations = stagingPhotos.map { PhotoAnnotation(photo: $0) }
                newState.photoSections = [PhotoSection(header: "photos", items: stagingPhotos)]
                newState.nextPage = (response.data?.photos.page ?? 0) + 1
                newState.enabledRight = !isEndPage(total: response.data?.photos.total ?? 0)
                newState.enabledLeft = !isFirstPage(startIndex: newState.startIndex)
                newState.refreshed = true
            }
        }
        return newState
    }
}

extension PhotoGeoReactor {
    func isEndPage(total: Int) -> Bool {
        return currentState.nextPage >= total
    }
    func isFirstPage(startIndex: Int) -> Bool {
        return startIndex <= 0
    }
}
