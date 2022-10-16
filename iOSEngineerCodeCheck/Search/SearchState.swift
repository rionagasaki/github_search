//
//  SearchState.swift
//  iOSEngineerCodeCheck
//
//  Created by Rio Nagasaki on 2022/10/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import Dispatch

struct SearchState:Equatable {
    var search_words:String
    var search_results:[SearchItem]
    static var initial = SearchState(search_words: "", search_results: .init([]))
}


public struct SearchResult: Codable{
    let items: [SearchItem]
}

public struct SearchItem: Codable, Equatable{
    let fullName:String?
    let owner:Owner?
    let language:String?
    let stargazersCount:Int?
    let watchersCount:Int?
    let forksCount:Int?
    let openIssuesCount:Int?
}

public struct Owner:Codable, Equatable{
    var avatarUrl:String?
}
