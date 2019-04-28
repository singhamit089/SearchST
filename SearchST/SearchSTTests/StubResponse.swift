//
//  StubResponse.swift
//  SearchSTTests
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation

class StubResponse {
    static func fromJSONFile(filePath: String) -> Data {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            fatalError("Invalid data from json file")
        }
        return data
    }
}
