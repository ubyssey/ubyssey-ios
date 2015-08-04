//
//  TopicArticlesPaginationAdapter.swift
//  ubyssey
//
//  Created by Nathan Yee on 2015-07-28.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class TopicArticlesPaginationAdapter {
    let api: UbysseyAPI

    init(api: UbysseyAPI) {
        self.api = api
    }

    func getNext(callback: [Article] -> Void, topicId: Int) {
        self.api.getTopicArticles({(articlesData: JSON) -> Void in
            var articles: [Article] = []

            let articlesJson = articlesData["results"]
            for (index: String, articleData: JSON) in articlesJson {
                articles.append(Article(articleData: articleData))
            }

            callback(articles)
        }, topicId: topicId)
    }
}
