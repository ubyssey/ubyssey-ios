//
//  ArticleParser.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-20.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class ArticleParser {
    var article: Article!
    var articleObjects: [ArticleObject] = []
    
    func consume(article: Article) -> ArticleParser {
        self.article = article
        return self
    }
    
    func parseContent() -> ArticleParser {
        //articleObjects.append(ArticleHeader())
        articleObjects.append(ArticleTitle(data: JSON(["data": article.longHeadline])))
        
        for (index: String, var data: JSON) in self.article.content {
            switch (data["type"].stringValue) {
            case "image":
                articleObjects.append(ArticleImage(data: data))
                break
            case "poll":
                articleObjects.append(ArticlePoll(data: data))
                break
            case "paragraph":
                articleObjects.append(ArticleContent(data: data))
                break
            default:
                break
            }
        }
        
        return self
    }
    
    func getItems() -> [ArticleObject] {
        return self.articleObjects
    }
    
    func iterator() -> ArticleIterator {
        return ArticleIterator(articles: self.articleObjects)
    }
    
    func filter(type: String) -> [ArticleObject] {
        return articleObjects.filter { (element: ArticleObject) -> Bool in
            return element.type == type
        }
    }
}