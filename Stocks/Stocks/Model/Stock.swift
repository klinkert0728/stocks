//
//  Stock.swift
//  Stocks
//
//  Created by Daniel Klinkert Houfer on 4/21/17.
//  Copyright © 2017 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class Stock: Object, Mappable {
    dynamic var name                = ""
    dynamic var symbol              = ""
    dynamic var lastPrice           = 0.0
    dynamic var change              = 0.0
    dynamic var changePercent       = 0.0
    dynamic var marketCap           = 0.0
    dynamic var volume              = 0.0
    dynamic var changeYTD           = 0.0
    dynamic var changeYTDPercent    = 0.0
    dynamic var high                = 0.0
    dynamic var low                 = 0.0
    dynamic var open                = 0.0
    
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
     func mapping(map: Map) {
        
        name                <-  map["Name"]
        symbol              <-  map["Symbol"]
        lastPrice           <-  map["LastPrice"]
        change              <-  map["Change"]
        changePercent       <-  map["ChangePercent"]
        marketCap           <-  map["MarketCap"]
        volume              <-  map["Volume"]
        changeYTD           <-  map["ChangeYTD"]
        changePercent       <-  map["ChangeYTD"]
        changeYTDPercent    <-  map["ChangePercentYTD"]
        high                <-  map["High"]
        low                 <-  map["Low"]
        open                <-  map["Open"]
    }
    
    
    class func addStock(endPoint:DKHEndPoint, closure:@escaping (_ stocks:Stock?,_ error:Error?)->()) {
        
        Alamofire.request(endPoint.url, method: endPoint.method, parameters: endPoint.parameters, encoding: endPoint.parameterEncoding, headers: endPoint.customHeaders).responseObject { (response:DataResponse<Stock>) in
            
            if let stocks = response.result.value, response.result.isSuccess {
                
                Realm.update(updateClosure: { (realm) in
                    realm.add(stocks, update: true)
                })
                closure(stocks, nil)
                
            }else {
                
                closure(nil,response.result.error)
                
            }
        }
    }
    
    
    class func getStocksFromDB(clousure:@escaping ([Stock])->()) {
        
        Realm.update { (realm) in
            let stocks = realm.objects(Stock.self)
            if !stocks.isEmpty {
                let array = Array(stocks)
                clousure(array)
            }else {
                clousure([Stock]())
            }
        }
    }
    
}


class StockPreview:Object, Mappable {
    
    dynamic var name        = ""
    dynamic var symbol      = ""
    dynamic var exchange    = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        name                    <-  map["Name"]
        symbol                  <-  map["Symbol"]
        exchange                <-  map["Exchange"]
    }
    
    class func addStockPreview(endPoint:DKHEndPoint, closure:@escaping (_ stocks:[StockPreview]?,_ error:Error?)->()) {
        
        Alamofire.request(endPoint.url, method: endPoint.method, parameters: endPoint.parameters, encoding: endPoint.parameterEncoding, headers: endPoint.customHeaders).responseArray { (response:DataResponse<[StockPreview]>) in
            
            if let stocksPreview = response.result.value, response.result.isSuccess {
             
                closure(stocksPreview, nil)
                
            }else {

                closure(nil,response.result.error)
            }
        }
    }

    
}
