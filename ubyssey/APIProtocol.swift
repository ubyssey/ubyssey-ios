//
//  APIProtocol.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-07.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import Foundation

protocol APIProtocol {
    func getFrontPage(callback: (JSON) -> Void)
}