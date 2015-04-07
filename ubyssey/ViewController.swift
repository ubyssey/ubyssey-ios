//
//  ViewController.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-06.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:ArticleTableViewCell? = tableView.dequeueReusableCellWithIdentifier("ArticleTableViewCell") as? ArticleTableViewCell
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

