//
//  ArticleContent.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-20.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class ArticleContent: ArticleObject {
    let text: String
    var font: UIFont
    var topMargin = CGFloat(10)
    var bottomMargin = CGFloat(10)
    var leftMargin = CGFloat(15)
    var rightMargin = CGFloat(15)
    
    init(data: JSON) {
        text = data["data"].stringValue
        self.font = Styles.defaultFont()
        super.init(type: data["type"].stringValue)
    }
    
    override func getSize(parentFrame: CGRect) -> CGSize {
        
        
        let rect = self.font.sizeOfString(text, constrainedToWidth: Double(parentFrame.size.width - leftMargin - rightMargin))

        return rect
    }
    
    override func draw(view: ScrollViewDrawable, positionY: CGFloat) -> CGFloat {
        let screenRect = UIScreen.mainScreen().bounds
        let size = getSize(screenRect)

        let label = UILabel()
        label.numberOfLines = 0
        label.text = self.text
        label.textColor = UIColor.blackColor()
        label.font = self.font
        
        label.frame = CGRectMake(leftMargin, positionY + topMargin, size.width, size.height + bottomMargin)
        view.addSubview(label)
        return size.height + bottomMargin + topMargin
    }
}