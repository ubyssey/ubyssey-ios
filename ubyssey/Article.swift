//
//  Article.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-06.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class Article {
    let longHeadline: String
    let shortHeadline: String
    let image: UbysseyImage
    let content: JSON
    let section: String
    let publishedAt: (NSDate?, NSDateFormatter?)
    let importance: Int
    let slug: String
    let estimatedReadingTime: Int  // estimated time is calculated in minutes
    
    var imageUrl: String {
        get {
            return self.image.url
        }
    }
    
    init(articleData: JSON) {
        func parseTime(timeString: String) -> (NSDate?, NSDateFormatter?) {
            if (count(timeString) == 0) {
                return (nil, nil)
            }

            let formatter = NSDateFormatter()
            if (count(timeString) == 20 && timeString.hasSuffix("Z")) {
                // remove the trailing "Z" from timeString
                var tempString = timeString
                tempString.removeRange(advance(tempString.endIndex, -1)..<tempString.endIndex)

                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            }
            return (formatter.dateFromString(timeString), formatter)
        }
        println(articleData)
        self.longHeadline = articleData["long_headline"].stringValue
        self.shortHeadline = articleData["short_headline"].stringValue
        self.image = UbysseyImage(imageData: articleData["featured_image"])
        self.content = articleData["content"]
        self.section = articleData["section"]["name"].stringValue
        self.publishedAt = parseTime(articleData["published_at"].stringValue)
        self.importance = articleData["importance"].intValue
        self.slug = articleData["slug"].stringValue
        self.estimatedReadingTime = articleData["est_reading_time"].intValue
    }
}