//
//  SearchRepository.swift
//  GitSearch
//
//  Created by Mac on 12/5/20.
//  
//

import RxCocoa
import RxSwift

// MARK: - SearchRepositoryProtocol
protocol SearchRepositoryProtocol {
    var searchDataSource: BehaviorRelay<[SearchSectionItem]> { get }
    
    func searchRepositories(by text: String)
}

// MARK: - SearchRepository
class SearchRepository {
    
    // - Internal Properties
    var searchDataSource = BehaviorRelay<[SearchSectionItem]>(value: [])
    
    // - Private Properties
    private var disposeBag = DisposeBag()
    private var requestBag = DisposeBag()
    private var searchNetworkProvider: SearchNetworkProviderProtocol
    
    init(searchNetworkProvider: SearchNetworkProviderProtocol) {
        self.searchNetworkProvider = searchNetworkProvider
    }
    
    private func prepareRequests(for text: String) -> [Single<SearchResponseModel>] {
        let firstRequestModel = SearchRequestModel(text: text, page: 1)
        let secondRequestModel = SearchRequestModel(text: text, page: 2)
        
        let firstRequest = self.searchNetworkProvider.searchRepository(with: firstRequestModel)
        let secondRequest = self.searchNetworkProvider.searchRepository(with: secondRequestModel)
        
        return [firstRequest, secondRequest]
    }
    
    private func configDataSource(for response: SearchResponseModel) {
        let searchItems = response.items.compactMap({ RepositoryItem(model: $0) })
        let seearchSection = SearchSectionItem(id: "\(response.totalCount) " + "Repositories", items: searchItems)
        self.searchDataSource.accept([seearchSection])
    }
}

// MARK: - SearchRepository: SearchRepositoryProtocol
extension SearchRepository: SearchRepositoryProtocol {
    
    func searchRepositories(by text: String) {
        self.requestBag = DisposeBag()
        
        guard !text.isEmpty else {
            self.searchDataSource.accept([])
            return
        }
        
        let requests = self.prepareRequests(for: text)
        
        Single.zip(requests)
            .subscribe(onSuccess: { [weak self] response in
                guard let response = response.first else {
                    self?.searchDataSource.accept([])
                    return
                }
                self?.configDataSource(for: response)
            }, onError: { error in
                debugPrint(error)
            }).disposed(by: self.requestBag)
    }
}
