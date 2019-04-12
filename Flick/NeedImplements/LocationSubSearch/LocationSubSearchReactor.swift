//
//  HomeReactor.swift
//  Flick
//
//  Created by tskim on 30/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//
// https://dribbble.com/shots/3328958-Photo-Search-Interaction

import ReactorKit
import RxSwift

class LocationSubSearchReactor: Reactor {

    let initialState = State(locationResults: [])

    private let geoRepository: FlickrGeoRepositoryType

    init(geo: FlickrGeoRepositoryType) {
        self.geoRepository = geo
    }

    enum Action {
        case setLocation(String?)
        case selectedLocation(Int)
        case setSwitchMap(LocationResult)
    }

    struct State {
        fileprivate var locationResults: [LocationResult]

        public init(locationResults: [LocationResult]) {
            self.locationResults = locationResults
        }

        var locationSections: [LocationSubSection]?
        var tapsLocationResult: LocationResult?
        var selectedLocationResult: LocationResult?
        var loading: Bool?
        var error: Error?

    }

    enum Mutation {
        case setLoading(Bool)
        case switchMapView(LocationResult)
        case selectedLocation(Int)
        case setLocationResults(Resources<LocationResultSet>)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .selectedLocation(let index):
            return Observable.just(Mutation.selectedLocation(index))
        case .setSwitchMap(let locationResult):
            return Observable.just(Mutation.switchMapView(locationResult))
        case .setLocation(let location):
            guard let location = location, location.isNotEmpty else { return .empty() }
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                self.geoRepository.findLocation(location).asObservable().asObservable().map { Mutation.setLocationResults($0) },
                Observable.just(Mutation.setLoading(false))
                ])
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = State(locationResults: state.locationResults)
        switch mutation {
        case .selectedLocation(let index):
            newState.selectedLocationResult = state.locationResults[index]
        case .switchMapView(let locationResult):
            newState.tapsLocationResult = locationResult
        case .setLoading(let loading):
            newState.loading = loading
        case .setLocationResults(let result):
            newState.locationResults = result.data?.results ?? []
            newState.locationSections = [LocationSubSection(header: "location", items: newState.locationResults)]

            newState.error = result.error
        }
        return newState
    }
}
