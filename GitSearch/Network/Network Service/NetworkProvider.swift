//
//  NetworkProvider.swift
//  GitSearch
//
//  Created by Mac on 12/5/20.
//

import Foundation
import Moya
import RxSwift

class NetworkProvider: NSObject {
    
    var provider: MoyaProvider<APIService>
        
    override init() {
        self.provider = MoyaProvider<APIService>(plugins: [CustomNetworkLoggerPlugin(verbose: true)])
        //self.provider = MoyaProvider<APIService>(plugins: [])

        super.init()
        
    }
    
    func request(target: APIService) -> Single<Response> {
        return privateRequest(target: target)
            .flatMap { response -> Single<Response> in
                return Single.just(response)
            }
    }
    
    func parse<T: Decodable>(data: Data, for type: T.Type) -> Single<T> {
        do {
            let response: T = try JSONDecoder().decode(type.self, from: data)
            return Single.just(response)
        } catch {
            print(error)
            return Single.error(error)
        }
    }
    
    private func privateRequest(target: APIService) -> Single<Response> {
        return provider.rx.request(target)
            .do(onSuccess: { _ in
                NetworkActivityIndicatorManager.networkOperationFinished()
            }, onError: { _ in
                NetworkActivityIndicatorManager.networkOperationFinished()
            }, onSubscribe: {
                NetworkActivityIndicatorManager.networkOperationStarted()
            })
    }
}
