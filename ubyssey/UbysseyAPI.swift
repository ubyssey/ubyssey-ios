//
//  UbysseyAPI.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-07.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class UbysseyAPI {
    let resolver: APIProtocol
    init(dataResolver: APIProtocol) {
        self.resolver = dataResolver
    }
    
    func getFrontPage(callback: (JSON) -> Void) {
        resolver.getFrontPage(callback)
    }
    
    func getArticle() {
    
    }
    
    func getSections(callback: (JSON) -> Void) {
        resolver.getSections(callback)
    }
}