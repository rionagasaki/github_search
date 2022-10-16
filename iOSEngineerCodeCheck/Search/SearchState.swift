//
//  SearchState.swift
//  iOSEngineerCodeCheck
//
//  Created by Rio Nagasaki on 2022/10/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import Dispatch

struct SearchState {
    var search_words:String
    var search_results:[SearchItem]
    static var initial = SearchState(search_words: "", search_results: .init([]))
}


struct SearchResult: Decodable{
    let items: [SearchItem]
}

struct SearchItem: Decodable{
    let fullName:String?
    let owner:Owner?
    let language:String?
    let stargazersCount:Int?
    let watchersCount:Int?
    let forksCount:Int?
    let openIssuesCount:Int?
}

struct Owner:Decodable{
    var avatarUrl:String?
}
