//
//  ArticleDetailViewController.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-09.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    var article: Article?
    override func viewDidLoad() {
        //self.navigationController?.title = article?.longHeadline
        println(article!.longHeadline)
        println(article!.shortHeadline)
        initializeView()
    }
    
    func initializeView() {
        article?.content
    }
}
