//
//  Cover.swift
//  SearchST
//
//  Created by Amit  Singh on 29/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation

public struct Cover : Codable {
    
    var url:String?
    var width:Int?
    var height:Int?
    
    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
    }
}
