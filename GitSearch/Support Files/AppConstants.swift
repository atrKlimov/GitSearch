//
//  AppConstants.swift
//  GitSearch
//
//  Created by Mac on 12/5/20.
//

import Foundation

public extension URL {
    /// Base URL path
    static let baseURL: URL = URL(string: Bundle.main.infoDictionary!["API_BASE_ENDPOINT"] as! String)!
}
