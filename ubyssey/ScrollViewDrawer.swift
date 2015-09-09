//
//  ScrollViewDrawer.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-05-05.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

/*
    This class basically manages the "currentPosition" of the drawable. 
    IE, what Y position to place the next ArticleObject next.
*/

class ScrollViewDrawer {
    let view: ScrollViewDrawable
    var currentY = CGFloat(0)
    
    init(view: UIScrollView) {
        self.view = ScrollViewDrawable(scrollView: view)
    }
    
    func draw(items: [ArticleObject]) {
        for item in items {
            currentY += item.draw(view, positionY: currentY)
        }
        
        setContentSize()
    }
    
    func setContentSize() {
        let screenRect = UIScreen.mainScreen().bounds
        view.contentSize = CGSize(width: screenRect.size.width, height: currentY)
    }

    func clearScrollView() {
        view.clearScrollView()
    }
}