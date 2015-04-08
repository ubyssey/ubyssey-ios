//
//  Transporter.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-07.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation
import Alamofire

class Transporter {
    let route: String
    let method: Alamofire.Method
    let params: [String: AnyObject]?

    init(route: String, method: Alamofire.Method, params: [String: AnyObject]?) {
        self.route = route
        self.method = method
        self.params = params
    }
    
    convenience init(route: String, methodString:String, params: [String: AnyObject]?) {
        var method = Method.GET
        
        if (methodString == "GET") {
            method = Method.GET
        } else if (methodString == "POST") {
            method = Method.POST
        }
        
        self.init(route: route, method: method, params: params)
    }
    
    func resolve(callback: (JSON) -> Void) {
        Alamofire.request(method, route, parameters: params).responseJSON { (req, res, json, error) -> Void in
            self.respondTo(callback, error: error, json: json)
        }
    }
    
    func respondTo(callback: (JSON) -> Void, error: AnyObject?, json: AnyObject?) {
        if (error != nil) {
            println(error)
        } else if let jsonData: AnyObject = json {
            callback(JSON(jsonData))
        }
    }
}