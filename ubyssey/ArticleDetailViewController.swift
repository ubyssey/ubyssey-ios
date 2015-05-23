//
//  ArticleDetailViewController.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-09.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var article: Article?
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
    }
    
    func initializeView() {
        if let article = article {
            let items: [ArticleObject] = ArticleParser().consume(article).parseContent().getItems()
            var currentPosition = CGFloat(0)
            mainScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: currentPosition)
            
            let drawer = ScrollViewDrawer(view: mainScrollView)
            drawer.draw(items)
            
        }
    }
    
}
