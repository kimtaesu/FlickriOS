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

class TextSubSearchReactor: Reactor {

    let initialState: State

    init(keywords: [String]) {
        initialState = State(keywords: keywords, searchKeyword: "")
    }

    enum Action {
        case loadKeywords([String])
        case setSearchKeyword(String?)
        case tapsSuggestionKeyword(Int)
        case tapsDone
    }

    struct State {
        var keywords: [String]
        var searchKeyword: String

        public init(keywords: [String], searchKeyword: String) {
            self.keywords = keywords
            self.searchKeyword = searchKeyword
        }
        
        var resultSearchKeyword: String?
        var tapsSuggestionKeyword: String?
        var keywordSections: [TextSubSection]?
    }

    enum Mutation {
        case loadKeywords([String])
        case tapsSuggestionKeyword(Int)
        case setSearchKeyword(String)
        case tapsDone
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapsDone:
            return .just(Mutation.tapsDone)
        case .setSearchKeyword(let keyword):
            guard let keyword = keyword else { return .empty() }
            return .just(Mutation.setSearchKeyword(keyword))
        case .tapsSuggestionKeyword(let index):
            return .just(Mutation.tapsSuggestionKeyword(index))
        case .loadKeywords(let keywords):
            return .just(Mutation.loadKeywords(keywords))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .tapsDone:
            newState.resultSearchKeyword = state.searchKeyword
        case .setSearchKeyword(let keyword):
            newState.searchKeyword = keyword
        case .tapsSuggestionKeyword(let index):
            let keyword = state.keywords[index]
            newState.tapsSuggestionKeyword = keyword
            newState.searchKeyword = keyword
        case .loadKeywords(let keywords):
            newState.keywords = keywords
            newState.keywordSections = [TextSubSection(header: "texts", items: keywords)]
        }
        return newState
    }
}
