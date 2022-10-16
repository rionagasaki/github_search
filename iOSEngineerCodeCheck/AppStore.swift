//
//  AppStore.swift
//  iOSEngineerCodeCheck
//
//  Created by Rio Nagasaki on 2022/10/16.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import RxSwift
import RxCocoa

internal final class AppStore {
    private let _searchState = BehaviorRelay<SearchState>(value: .initial)
    
    var searchState: SharedSequence<DriverSharingStrategy, SearchState>{
        return _searchState.asDriver()
    }
    
    func dispatchSearchAction(_ action: SearchAction){
        var searchState = _searchState.value
        searchState = SearchReducer.reducer(state: searchState, action: action)
        _searchState.accept(searchState)
    }
    
}

let appStore = AppStore()
