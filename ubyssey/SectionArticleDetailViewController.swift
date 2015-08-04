//
//  SectionArticleDetailViewController.swift
//  ubyssey
//
//  Created by Nathan Yee on 2015-07-12.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class SectionArticleDetailViewController: UIViewController {
    @IBOutlet weak var mainScrollView: UIScrollView!

    var article: Article?
    override func viewDidLoad() {
        super.viewDidLoad()

        var titleView = UIImageView(image: UIImage(named: "ubyssey_logo_small"))
        titleView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = titleView

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
