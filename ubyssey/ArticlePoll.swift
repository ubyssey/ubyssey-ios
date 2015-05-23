//
//  ArticlePoll.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-20.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class ArticlePoll: ArticleObject {
    init(data: JSON) {
        super.init(type: data["type"].stringValue)
    }
    
    override func getSize(parentFrame: CGRect) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
}