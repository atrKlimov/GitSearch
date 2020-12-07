//
//  APIServise.swift
//  GitSearch
//
//  Created by Mac on 12/5/20.
//

import Foundation
import Moya

// MARK: - APIService
enum APIService {
    case search(searchModel: SearchRequestModel)
}

// MARK: - APIService: TargetType
extension APIService: TargetType {
    
    var baseURL: URL {
        return URL.baseURL
    }
    
    var path: String {
        switch self {
        case .search:
            return "search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let searchModel):
            return .requestParameters(parameters: searchModel.dictionary, encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal))
        
        }
    }
    
    var headers: [String: String]? {
        let headers: [String: String] = ["accept": "application/vnd.github.v3+json"]
        
        return headers
    }
}

// MARK: - Encodable
extension Encodable {
    
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] } ?? [:]
    }
}
