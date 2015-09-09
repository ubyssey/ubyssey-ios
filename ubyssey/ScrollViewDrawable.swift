//
//  ScrollViewDrawable.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-05-05.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class ScrollViewDrawable {
    var scrollView: UIScrollView
    var subViews: [UIView]
    var contentSize: CGSize {
        get {
            return scrollView.contentSize
        }
        set {
            scrollView.contentSize = newValue
        }
    }
    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        self.subViews = []
    }
    
    func addSubview(view: UIView) {
        subViews.append(view)
        scrollView.addSubview(view)
    }

    func clearScrollView() {
        for view in subViews {
            view.removeFromSuperview()
        }
        subViews = []
    }
}
