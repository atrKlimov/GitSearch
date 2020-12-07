//
//  SearchNetworkProvider.swift
//  GitSearch
//
//  Created by Mac on 12/6/20.
//

import RxSwift

// MARK: - SearchNetworkProviderProtocol
protocol SearchNetworkProviderProtocol {
    
    /**
     Search Session by key
     
     - Returns:
     Should Return PrimitiveSequence<SingleTrait,SearchResponseModel> in success cases. Should return Single.error(Error) in case of errors from server(invalid params or same problems connected with server, for details -> uncomment network logged plugin)
     */
    func searchRepository(with model: SearchRequestModel) -> Single<SearchResponseModel>
}

// MARK: - SearchNetworkProvider
class SearchNetworkProvider: NetworkProvider, SearchNetworkProviderProtocol {
    
    func searchRepository(with model: SearchRequestModel) -> Single<SearchResponseModel> {
        print("request ", Date().timeIntervalSince1970)
       return self.request(target: .search(searchModel: model))
        .flatMap { response -> Single<SearchResponseModel> in
            print("parse", Date().timeIntervalSince1970)
            return self.parse(data: response.data, for: SearchResponseModel.self)
        }
        .catchError { error -> PrimitiveSequence<SingleTrait, SearchResponseModel> in
            return Single.error(error)
        }
    }
}
