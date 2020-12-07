//
//  DependenciesHolder.swift
//  GitSearch
//
//  Created by Mac on 12/6/20.
//

import Foundation
import Swinject

class DependenciesHolder {
    
    func injector() -> Container {
        let container = Container()
        
        container.register(SearchNetworkProvider.self) { _ -> SearchNetworkProvider in
            return SearchNetworkProvider()
        }.inObjectScope(.transient)
        
       return container
    }
}
