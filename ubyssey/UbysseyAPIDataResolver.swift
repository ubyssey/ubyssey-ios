//
//  UbysseyAPIDataResolver.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-07.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class UbysseyAPIDataResolver: APIProtocol {
    let baseRoute = "http://dev.ubyssey.ca/api/"
    
    func getFrontPage(callback: (JSON) -> Void) {
        let route = baseRoute + "frontpage/"
        let transporter = Transporter(route: route, methodString: "GET", params: nil)
        transporter.resolve(callback)
    }
    
    func getSections(callback: (JSON) -> Void) {
        let route = baseRoute + "sections/"
        let transporter = Transporter(route: route, methodString: "GET", params: nil)
        transporter.resolve(callback)
    }

    func getTopics(callback: (JSON) -> Void) {
        let route = baseRoute + "topics/"
        let transporter = Transporter(route: route, methodString: "GET", params: nil)
        transporter.resolve(callback)
    }

    func getTopicArticles(callback: (JSON) -> Void, topicId: Int) {
        let route = baseRoute + "topics/\(topicId)/articles/"
        let transporter = Transporter(route: route, methodString: "GET", params: nil)
        transporter.resolve(callback)
    }
}
