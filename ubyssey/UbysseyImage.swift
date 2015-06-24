//
//  UbysseyImage.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-07.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class UbysseyImage {
    let url: String
    let caption: String
    let type: String
    
    init(imageData: JSON) {
        self.url = imageData["url"].stringValue
        self.caption = imageData["caption"].stringValue
        self.type = imageData["type"].stringValue
    }
}