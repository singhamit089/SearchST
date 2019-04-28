//
//  StoryTelAPI.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import Foundation
import Moya

public var stubJsonPath = ""

public enum StoryTel {
    case ItemSearch(query: String, page: Int)
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

extension StoryTel: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.storytel.net")!
    }
    
    public var path: String {
        switch self {
        case .ItemSearch(query: _, page: _):
            return "/search"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .ItemSearch(query: _, page: _):
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .ItemSearch(query: _, page: _):
            return StubResponse.fromJSONFile(filePath: stubJsonPath)
        }
    }
    
    public var task: Task {
        switch self {
        case let .ItemSearch(query: query, page: page):
            let params: [String:Any] = ["query":query.urlEscaped, "page":page]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            }
        }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

public var StorytelProvider = MoyaProvider<StoryTel>(
    endpointClosure: endpointClosure,
    requestClosure: requestClosure,
    plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)]
)

public func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let endpointClosure = { (target: StoryTel) -> Endpoint in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    
    return defaultEndpoint
}
    
let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        // Modify the request however you like.
        done(.success(request))
    } catch {
        // done(.failure(MoyaError.underlying(error, <#Response?#>)))
    }
}



