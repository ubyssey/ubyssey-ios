//
//  TrendingViewController.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-05-31.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        var titleView = UIImageView(image: UIImage(named: "ubyssey_logo_small"))
        titleView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = titleView
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:TrendingTableViewCell? = tableView.dequeueReusableCellWithIdentifier("TrendingTableViewCell") as? TrendingTableViewCell
        
        return cell!

    }
}
