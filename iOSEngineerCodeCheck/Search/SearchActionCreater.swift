//
//  SearchActionCreater.swift
//  iOSEngineerCodeCheck
//
//  Created by Rio Nagasaki on 2022/10/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import RxSwift
import Foundation

struct SearchActionCreater{
    
    private static let disposeBag = DisposeBag()
    
    static func searchKeywordEnter(word:String){
        appStore.dispatchSearchAction(.searchText_entered(word))
    }
    
    static func searchButtonClicked(word: String){
        if word.count != 0 {
            guard let url = URL(string: "https://api.github.com/search/repositories?q=\(word)") else { return }
            let urlRequest = URLRequest(url: url)
            URLSession.shared.rx.response(request: urlRequest).subscribe { response, data in
                let httpResponse = response as HTTPURLResponse
                if httpResponse.statusCode != 200 { return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try! decoder.decode(SearchResult.self, from: data)
                appStore.dispatchSearchAction(.searchButton_clicked(result))
            } onError: { error in
                print(error)
            }.disposed(by: disposeBag)
        }
    }
}

