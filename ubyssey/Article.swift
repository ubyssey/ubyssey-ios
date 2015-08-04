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
    //let publishedAt: NSDate?
    let importance: Int
    let slug: String
    
    var imageUrl: String {
        get {
            return self.image.url
        }
    }
    
    init(articleData: JSON) {
        println(articleData)
        self.longHeadline = articleData["long_headline"].stringValue
        self.shortHeadline = articleData["short_headline"].stringValue
        self.image = UbysseyImage(imageData: articleData["featured_image"])
        self.content = articleData["content"]
        self.section = articleData["section"]["name"].stringValue
        //self.publishedAt = parseTime(articleData["published_at"].stringValue)!
        self.importance = articleData["importance"].intValue
        self.slug = articleData["slug"].stringValue
    }
    
    func parseTime(timeString: String) -> NSDate? {
        if (count(timeString) == 0) {
            return nil
        }
        
        let formatter = NSDateFormatter()
        if (count(timeString) == 24) {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        } else if (count(timeString) == 10){
            formatter.dateFormat = "yyyy-MM-dd"
        }
        
        return formatter.dateFromString(timeString)
    }
}