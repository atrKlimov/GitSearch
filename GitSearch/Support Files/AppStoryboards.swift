//
//  AppStoryboards.swift
//  GitSearch
//
//  Created by Mac on 12/5/20.
//

import Foundation

enum AppStoryboards: String, CaseIterable {
    
    case search = "Search"
    
    var storyboard: String {
        return self.rawValue + "View"
    }
}
