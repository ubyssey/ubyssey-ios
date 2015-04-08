//
//  ArticleTableViewCell.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-06.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleTimeSince: UILabel!
    @IBOutlet weak var articlePublishedAt: UILabel!
    @IBOutlet weak var articleSection: UILabel!
    
    func setData(article: Article) {
        articleSection.text = article.section.uppercaseString
        articleTitle.text = article.longHeadline
        articleImageView.sd_setImageWithURL(NSURL(string: article.imageUrl))
        articleImageView.clipsToBounds = true
    }
}
