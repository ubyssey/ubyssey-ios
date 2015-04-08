//
//  UbysseyImage.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-07.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

class UbysseyImage {
    let title: String
    let url: String
    let thumb: String
    let caption: String
    let type: String
    init(imageData: JSON) {
        self.title = imageData["image"]["title"].stringValue
        self.url = imageData["image"]["url"].stringValue
        self.thumb = imageData["image"]["thumb"].stringValue
        self.caption = imageData["caption"].stringValue
        self.type = imageData["type"].stringValue
    }
}