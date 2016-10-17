//
//  Net.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/10/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import Foundation
import BrightFutures

class Net{
    
    
    class func connectOrder(params: [String: AnyObject]) -> Future<AYOrders, NSError> {
        let promise = Promise<AYOrders, NSError>()
        let urlString = AYNet.SEARCH_URL
        //        Webservice.cancelRequestForKey(kMeRequestKey)
        Webservice.request(urlString, params: params, animated: true).onSuccess { (result: WebResult<AYOrders>) -> Void in
            promise.success(result.value!)
            }.onFailure { (error) -> Void in
                print("Error: \(error)")
                promise.failure(error)
        }
        return promise.future
    }
    
    class func connectHour(params: [String: AnyObject]) -> Future<AYResponse, NSError> {
        let promise = Promise<AYResponse, NSError>()
        let urlString = AYUploadHour.SEARCH_URL
        //        Webservice.cancelRequestForKey(kMeRequestKey)
        Webservice.request(urlString, params: params, animated: true).onSuccess { (result: WebResult<AYResponse>) -> Void in
            promise.success(result.value!)
            }.onFailure { (error) -> Void in
                print("Error: \(error)")
                promise.failure(error)
        }
        return promise.future
    }

    
    
}