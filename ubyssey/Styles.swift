//
//  Styles.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-09.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class Styles {
    
    // Colors
    
    class func mainColor() -> UIColor {
        let color = UIColor(red: 0/255, green: 105/255, blue: 204/255, alpha: 1.0)
        return color
    }
    
    // Fonts
    
    class func defaultFont() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: 17)!
    }
    
    class func titleFont() -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: 18)!
    }
    
    class func metaDataFont() -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: 17)!
    }
    
    class func captionFont() -> UIFont {
        return UIFont(name: "HelveticaNeue-LightItalic", size: 17)!
    }
}