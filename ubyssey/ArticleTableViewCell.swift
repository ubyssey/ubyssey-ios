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
        
        articleTimeSince.font = UIFont(name: "LFTEtica-SemiBold", size: 10)
        articleSection.font = UIFont(name: "LFTEtica-SemiBold", size: 10)

        articleTitle.text = article.longHeadline
        articleTitle.font = UIFont(name: "LFTEtica-Book", size: 18)
        
        
        articleImageView.sd_setImageWithURL(NSURL(string: article.imageUrl))
        articleImageView.clipsToBounds = true

        // If article was published between the current time and midnight of
        // the current day, show "HH:mm a", else show "yyyy-MM-dd"
        if article.publishedAt.0 != nil && article.publishedAt.1 != nil {
            let currentDate = NSDate()
            let currentDateFormatter = NSDateFormatter()
            currentDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if getyyyyMMdd((currentDate, currentDateFormatter)) ==
                getyyyyMMdd((article.publishedAt.0!, article.publishedAt.1!)) {
                articlePublishedAt.text = getHHmm_a((article.publishedAt.0!, article.publishedAt.1!))
                if articlePublishedAt.text == nil {
                    articlePublishedAt.text = ""
                }
            } else {
                let testStr = article.publishedAt.1!.stringFromDate(article.publishedAt.0!)
                articlePublishedAt.text = getyyyyMMdd((article.publishedAt.0!, article.publishedAt.1!))
                if articlePublishedAt.text == nil {
                    articlePublishedAt.text = ""
                }
            }
            if articlePublishedAt.text == nil {
                articlePublishedAt.text = ""
            }
        } else {
            articlePublishedAt.text = ""
        }

        articleTimeSince.text = String("\(article.estimatedReadingTime) minute read")
    }


    private func getyyyyMMdd(publishedAt: (NSDate, NSDateFormatter))
            -> String? {
        if publishedAt.1.dateFormat == "yyyy-MM-dd'T'HH:mm:ssZ" {
            var dateString = publishedAt.1.stringFromDate(publishedAt.0)
            dateString.removeRange(advance(dateString.startIndex, 10)..<dateString.endIndex)
            return dateString
        }
        return nil
    }

    private func getHHmm_a(publishedAt: (NSDate, NSDateFormatter)) -> String? {
        if publishedAt.1.dateFormat == "yyyy-MM-dd'T'HH:mm:ssZ" {
            var dateString = publishedAt.1.stringFromDate(publishedAt.0)
            // e.g. "1918-01-02T03:04:05-0000" -> "03:04:05-0000"
            dateString.removeRange(advance(dateString.startIndex, 0)..<advance(dateString.startIndex, 11))
            // e.g. "03:04:05-0000" -> "03:04"
            dateString.removeRange(advance(dateString.startIndex, 5)..<advance(dateString.endIndex, 0))

            // e.g. "03:04" -> "3:04 AM"
            // e.g. "12:01" -> "12:01 PM"
            var dateHour = dateString
            dateHour.removeRange(advance(dateString.startIndex, 2)..<advance(dateString.endIndex, 0))
            if let hour = dateHour.toInt() {
                if hour > 12 {
                    // truncate leading hours
                    dateString.removeRange(advance(dateString.startIndex, 0)..<advance(dateString.startIndex, 2))
                    return String(hour - 12) + dateString + " pm"
                }
                else if hour == 12 {
                    return dateString + " pm"
                } else if hour >= 10 {
                    return dateString + " am"
                } else {
                    // truncate leading 0
                    dateString.removeRange(advance(dateString.startIndex, 0)..<advance(dateString.startIndex, 1))
                    return dateString + " am"
                }
            }
        }
        return nil
    }
}
