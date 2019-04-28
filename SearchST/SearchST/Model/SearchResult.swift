//
//  SearchResult.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    var query:String?
    var filter:String?
    var nextPage:String?
    var totalCount:Int?
    var items:[Item]?
    
    enum CodingKeys: String, CodingKey {
        case query
        case filter
        case nextPage
        case totalCount
        case items
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        query = try values.decodeIfPresent(String.self, forKey: .query)
        filter = try values.decodeIfPresent(String.self, forKey: .filter)
        nextPage = try values.decodeIfPresent(String.self, forKey: .nextPage)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
        items = try values.decodeIfPresent([Item].self, forKey: .items)
    }
}
