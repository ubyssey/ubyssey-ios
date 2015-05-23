//
//  ArticleIterator.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-20.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class ArticleIterator {
    let articles: [ArticleObject]
    var currentPointer = 0
    
    init(articles: [ArticleObject]) {
        self.articles = articles
    }
    
    func hasNext() -> Bool {
        return true
    }

    func nextElement() -> ArticleObject {
        let article = articles[currentPointer]
        currentPointer += 1
        return article
    }
}