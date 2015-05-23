//
//  ArticleImage.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-20.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class ArticleImage: ArticleObject {
    let url: String
    let width: CGFloat
    let height: CGFloat
    
    init(data: JSON) {
        url = data["data"]["url"].stringValue
        width = CGFloat(data["data"]["width"].intValue)
        height = CGFloat(data["data"]["height"].intValue)
        
        super.init(type: data["type"].stringValue)
    }
    
    
    override func getSize(parentFrame: CGRect) -> CGSize {
        var width = self.width
        var height = self.height
        if (width > parentFrame.size.width) {
            width = parentFrame.size.width
            height = (self.height / self.width) * width
        }
        
        return CGSize(width: width, height: height)
    }
    
    override func draw(view: ScrollViewDrawable, positionY: CGFloat) -> CGFloat {
        let screenRect = UIScreen.mainScreen().bounds
        let size = getSize(screenRect)

        let imageView = UIImageView()
        imageView.sd_setImageWithURL(NSURL(string: self.url))
        imageView.frame = CGRectMake(0, positionY, size.width, size.height)
        
        view.addSubview(imageView)
        return size.height
    }
}