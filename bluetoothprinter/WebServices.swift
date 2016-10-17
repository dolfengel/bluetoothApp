//
//  WebServices.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/10/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import Foundation
import Alamofire
import Genome
import BrightFutures
import Async


struct AYNet {
    
    //sign in param
    static let USERNAME = "key"
    static let USERPASSWORD = "auth"
    static let USERTYPE = "type"
    
    //URL to connect
    static let SEARCH_URL = "https://savory7.com/rest/dashboard"
}

struct AYUploadHour {
    static let TYPE = "type"
    static let VERSION = "version"
    static let KEY = "key"
    static let AUTH = "auth"
    static let DATA = "data"
    static let PREPTIME = "prepTime"
    
    static let SEARCH_URL = "https://savory7.com/rest/dashboard"
}

class WebResult<T> {
    var value: T?
    var array: Array<T> = []
    init(value: T?, array: Array<T>) {
        self.value = value
        self.array = array
    }
    init(value: T?) {
        self.value = value
    }
}

enum ConvertingError : ErrorType {
    case UnableToConvertJson
    case UnableToConvertJsonParsed
}

class Webservice {
    
    static func toJson(value: AnyObject) throws -> Genome.JSON {
        if let json = value as? Genome.JSON {
            return json
        } else {
            throw ConvertingError.UnableToConvertJson
        }
    }
    
    class func request<T: BasicMappable>(urlString: String, params: [String: AnyObject]?, animated: Bool) -> Future<WebResult<T>, NSError> {
        print(urlString)
        
        let promise = Promise<WebResult<T>, NSError>()
        
        
        Alamofire.request(.POST, urlString, parameters: params, encoding: .JSON).responseJSON { (response) -> Void in
            
            Async.background {
            
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                response.result.error
                //let dataString = NSString(data: response.data!, encoding: NSUTF8StringEncoding)
                //print(dataString)
                mapResult(response, promise: promise)
                }.main{
                    //                    closeBlocking(animated)
            }
        }
        return promise.future
    }
    
    private class func mapResult<T: BasicMappable>(response: Response<AnyObject, NSError>, promise: Promise<WebResult<T>, NSError>) {
        switch response.result {
        case .Success(let value):
            Async.background {
                do {
                    if let array = value as? NSArray {
                        var resultArray: Array<T> = []
                        for arrayValue in array {
                            let json = try toJson(arrayValue)
                            let resultObject = try T.mappedInstance(json)
                            resultArray.append(resultObject)
                        }
                        Async.main {
                            promise.success(WebResult(value: nil, array: resultArray))
                        }
                    }else{
                        let json = try toJson(value)
                        let resultObject = try T.mappedInstance(json)
                        Async.main {
                            promise.success(WebResult(value: resultObject))
                        }
                    }
                } catch {
                    handleError(error)
                    Async.main {
                        promise.failure(NSError(domain: "UnableToConvertJson", code: -1, userInfo: nil))
                    }
                }
            }
        case .Failure(let error):
            handleError(error)
            promise.failure(error)
        }
    }
    
    class func handleError(error: ErrorType) {
        print(error)
    }
    
}


