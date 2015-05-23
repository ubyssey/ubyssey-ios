//
//  ArticleObject.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-20.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class ArticleObject {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    func getSize(parentFrame: CGRect) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func draw(view: ScrollViewDrawable, positionY: CGFloat) -> CGFloat {
        return CGFloat(0)
    }
}