//
//  SearchBuilder.swift
//  GitSearch
//
//  Created by Mac on 12/5/20.
//  
//

import Foundation
import UIKit
import Swinject

class SearchBuilder {
    static func build(injector: Container) -> SearchViewController {
        let viewController = SearchViewController.board(.search)
        
        let repository = SearchRepository(searchNetworkProvider: injector.resolve(SearchNetworkProvider.self)!)
        
        let viewModel = SearchViewModel(repository: repository)
    
        viewController.viewModel = viewModel
        
        return viewController
    }
}
