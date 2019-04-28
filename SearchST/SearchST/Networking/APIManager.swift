//
//  APIManager.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SVProgressHUD

public class API: StoryTelAPI {
    
    static let sharedAPI = API()
    
    public func searchItem(_ keyword: String, page: Int) -> Single<SearchResult> {
        
        return StorytelProvider.rx.request(StoryTel.ItemSearch(query: keyword, page: page))
            .map(SearchResult.self)
            .observeOn(MainScheduler.instance)
            .flatMap({ searchResult -> Single<SearchResult> in
                return Single.just(searchResult)
            })
    }
}
