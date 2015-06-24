//
//  ArticleTitle.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-05-23.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class ArticleTitle: ArticleContent {
    override func getFont() -> UIFont {
        return Styles.titleFont()
    }
    
}