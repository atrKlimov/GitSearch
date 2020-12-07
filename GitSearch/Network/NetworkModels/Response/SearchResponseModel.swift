//
//  SearchResponseModel.swift
//  GitSearch
//
//  Created by Mac on 12/6/20.
//

import Foundation

struct SearchResponseModel: Codable {
    var items: [RepositoryModel]
    var totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case items
        case totalCount = "total_count"
    }
}

struct RepositoryModel: Codable {
    var id: Int
    var name: String
    var starsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "full_name"
        case starsCount = "stargazers_count"
    }
}
