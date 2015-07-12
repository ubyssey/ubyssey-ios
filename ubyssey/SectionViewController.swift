//
//  SectionViewController.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-05-31.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class SectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var sectionsTableView: UITableView!

    var sections: [String] = []
    override func viewDidLoad() {
        var titleView = UIImageView(image: UIImage(named: "ubyssey_logo_small"))
        titleView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = titleView
        
        populateSections()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = sections[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        self.performSegueWithIdentifier("SectionArticleViewControllerSegue", sender: self)
    }
    
    func populateSections() {
        let api = UbysseyAPI(dataResolver: UbysseyAPIDataResolver())
        api.getSections { (data: JSON) -> Void in
            for (index: String, section: JSON) in data["results"] {
                self.sections.append(section["name"].stringValue)
            }
            self.sectionsTableView.reloadData()
        }
    }
}