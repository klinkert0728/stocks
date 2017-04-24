//
//  DKHEndPoint.swift
//  Stocks
//
//  Created by Daniel Klinkert Houfer on 4/21/17.
//  Copyright © 2017 Daniel Klinkert Houfer. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import ObjectMapper

protocol APIEndpoint {
    var baseUrl:URL { get }
    var path: String { get }
    var method:HTTPMethod { get }
    var parameters:[String:Any]? { get }
    var parameterEncoding: URLEncoding { get }
    var customHeaders: [String:String]? { get }
}

extension APIEndpoint {
    var url:URL {
        return baseUrl.appendingPathComponent(path)
    }
}

enum DKHEndPoint {
    
    case search(symbol:String)
    case lookup(name:String)
    
    
    
}


extension DKHEndPoint:APIEndpoint {
    
    
    var baseUrl:URL {
        switch  self {
            
        default:
            return URL(string:"http://dev.markitondemand.com/Api/v2/")!
        }
    }
    
    var path:String {
        switch self {
        case .search(symbol: _):
            return "Quote/json"
            
            
        case .lookup(name:_):
            return "Lookup/json"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
            
        default:
            return .get
        }
    }
    
    var parameters:[String:Any]? {
        
        switch  self {
            
        case .search(symbol: let currentSymbol):
            return ["symbol":currentSymbol]
            
        case .lookup(name: let name):
            return ["input":name]
        }
    }
    
    var customHeaders:[String:String]? {
        
        switch self {
        default:
            return [:]
        }
    }
    
    var parameterEncoding:URLEncoding {
        return URLEncoding.queryString
    }
}
