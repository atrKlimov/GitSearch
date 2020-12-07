//
//  SearchRequestModel.swift
//  GitSearch
//
//  Created by Mac on 12/5/20.
//

import Foundation

struct SearchRequestModel: Encodable {
        var text: String
        var page: Int
        var sort: String = "stars"
        var order: String = "desc"
        var size: Int = 15
        
    enum CodingKeys: String, CodingKey {
        case text = "q"
        case page
        case sort
        case order
        case size
    }

}
