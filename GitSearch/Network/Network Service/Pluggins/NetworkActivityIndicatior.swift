//
//  NetworkActivityIndicatior.swift
//  GitSearch
//
//  Created by Mac on 12/6/20.
//

import UIKit

class NetworkActivityIndicatorManager {
    
    private static var loadingCount = 0
    
    class func networkOperationStarted() {
        DispatchQueue.main.async {
            if loadingCount == 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            loadingCount += 1
        }
    }
    
    class func networkOperationFinished() {
        DispatchQueue.main.async {
            if loadingCount > 0 {
                loadingCount -= 1
            }
            if loadingCount == 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
