//
//  SearchReducer.swift
//  iOSEngineerCodeCheck
//
//  Created by Rio Nagasaki on 2022/10/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift

struct SearchReducer {
    static func reducer(state:SearchState, action:SearchAction) -> SearchState {
        var newState = state
        switch action {
        case .searchText_entered(let searchText):
            newState.search_words = searchText
        case .searchButton_clicked(let searchResult):
            newState.search_results = searchResult.items
        }
        return newState
    }
}
