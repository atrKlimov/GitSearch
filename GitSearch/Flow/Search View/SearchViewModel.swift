//
//  SearchViewModel.swift
//  GitSearch
//
//  Created by Mac on 12/5/20.
//  
//

import RxSwift
import RxCocoa

class SearchViewModel {

    // - Internal Properties
    var searchDataSource = BehaviorRelay<[SearchSectionItem]>(value: [])
    
    // - Private Properties
    private var disposeBag = DisposeBag()
    private var repository: SearchRepositoryProtocol

    init(repository: SearchRepositoryProtocol) {
        self.repository = repository
        self.binding()
    }
    
    func searchRepository(by text: String) {
        self.repository.searchRepositories(by: text)
    }
    
    // - Private BL
    private func binding() {
        self.repository.searchDataSource
            .bind(to: self.searchDataSource)
            .disposed(by: self.disposeBag)
    }

}
