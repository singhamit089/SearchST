//
//  Author.swift
//  SearchST
//
//  Created by Amit  Singh on 29/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation

public struct Author : Codable {
    
    var id:String?
    var name:String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
