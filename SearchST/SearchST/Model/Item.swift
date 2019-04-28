//
//  Item.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation

public struct Item: Codable {
    var id:String!
    var title:String?
    var originalTitle:String?
    var type:String?
    var description:String?
    var seriesInfo:String?
    var authors:[Author]?
    var narrators:[Narrator]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle
        case type
        case description
        case seriesInfo
        case authors
        case narrators
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        seriesInfo = try values.decodeIfPresent(String.self, forKey: .seriesInfo)
        authors = try values.decodeIfPresent([Author].self, forKey: .authors)
        narrators = try values.decodeIfPresent([Narrator].self, forKey: .narrators)
    }
}
