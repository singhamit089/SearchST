//
//  Protocols.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public protocol StoryTelAPI {
    func searchItem(_ keyword: String, page: Int) -> Single<SearchResult>
}
