//
//  PaginationAdapter.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-07.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class PaginationAdapter {
    let api: UbysseyAPI

    init(api: UbysseyAPI) {
        self.api = api
    }
    
    func getNext(callback: [Article] -> Void) {
        self.api.getFrontPage({(articlesData: JSON) -> Void in
            var articles: [Article] = []
            
            let articlesJson = articlesData["results"]
            for (index: String, articleData: JSON) in articlesJson {
                articles.append(Article(articleData: articleData))
            }
            
            callback(articles)
        })
    }
}