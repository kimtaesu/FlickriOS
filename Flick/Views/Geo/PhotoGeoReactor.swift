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

    let initialState = State(text: "", bbox: Enviroment.WORLD_BBOX, photoSections: [], annotations: [])

    private let repository: FlickrPhotoRepositoryType

    init(_ repository: FlickrPhotoRepositoryType) {
        self.repository = repository
    }
    enum Action {
        case setSearch
        case tapsPhoto(Int)
        case tapsAnnotationView(MKAnnotation?)
    }

    struct State {
        var text: String
        var bbox: String
        var photoSections: [PhotoSection]
        var mapAnnotations: [MKAnnotation]
        
        public init(text: String, bbox: String, photoSections: [PhotoSection], annotations: [MKAnnotation]) {
            self.text = text
            self.bbox = bbox
            self.photoSections = photoSections
            self.mapAnnotations = annotations
        }
        
        var selectedPhoto: Photo?
        var initLoading: Bool?
        var initError: Error?
        var selectedAnnotation: PhotoAnnotation?
    }

    enum Mutation {
        case setInitLoading(Bool)
        case setSearchResults(Resources<PhotoResponse>)
        case tapsPhoto(Photo)
        case tapsAnnotationView(PhotoAnnotation)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapsAnnotationView(let annotation):
            guard let annotation = annotation as? PhotoAnnotation else { return .empty() }
            return Observable.just(Mutation.tapsAnnotationView(annotation))
        case .tapsPhoto(let index):
            return Observable.just(Mutation.tapsPhoto(currentState.photoSections[0].items[index]))
        case .setSearch:
            return Observable.concat([
                Observable.just(Mutation.setInitLoading(true)),
                self.repository.geoSearch(currentState.text, page: 1, bbox: currentState.bbox).asObservable().map { Mutation.setSearchResults($0) },
                Observable.just(Mutation.setInitLoading(false))
                ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(text: state.text, bbox: state.bbox, photoSections: state.photoSections, annotations: state.mapAnnotations)
        switch mutation {
        case .tapsAnnotationView(let annotation):
            newState.selectedAnnotation = annotation
        case .tapsPhoto(let photo):
            newState.selectedPhoto = photo
        case .setInitLoading(let loading):
            newState.initLoading = loading
        case .setSearchResults(let response):
            let photos = response.data?.photos.photo ?? []
            newState.mapAnnotations = photos.map { PhotoAnnotation(photo: $0) }
            newState.photoSections = [PhotoSection(header: "photos", items: photos)]
            newState.initError = response.error
        }
        return newState
    }
}
