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
    var refreshControl: UIRefreshControl!

    // Int: id of section
    // String: name of section
    //
    // Invarient: no id has the same name as another id
    var sections: [(Int,String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        var titleView = UIImageView(image: UIImage(named: "ubyssey_logo_small"))
        titleView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = titleView

        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.sectionsTableView.addSubview(refreshControl)
        self.sectionsTableView.separatorStyle = UITableViewCellSeparatorStyle.None

        populateSections()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = sections[indexPath.row].1
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Do not run tableView.deselectRowAtIndexPath(indexPath, animated: false) here
        // since prepareForSegue relies on the row still being selected to set the
        // selectedSectionId of the destination SectionArticleViewController
        
        self.performSegueWithIdentifier("SectionArticleViewControllerSegue", sender: self)
    }

    func refresh() {
        populateSections()
    }

    func populateSections() {
        self.sections.removeAll()
        let api = UbysseyAPI(dataResolver: UbysseyAPIDataResolver())
        api.getSections { (data: JSON) -> Void in
            for (index: String, section: JSON) in data["results"] {
                self.sections.append(section["id"].intValue,
                    section["name"].stringValue)
            }
            self.sectionsTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "SectionArticleViewControllerSegue":
                if let indexPath = sectionsTableView.indexPathForSelectedRow() {
                    let viewController = segue.destinationViewController as! SectionArticleViewController
                    if let cell = sectionsTableView.cellForRowAtIndexPath(indexPath) {
                        if let cellLabel = cell.textLabel {
                            if let cellLabelText = cellLabel.text {
                                // NOTE: this assumes that every row number
                                // of sectionsTableView corresponds to the
                                // order of every section in sections (in
                                // ascending order)
                                viewController.selectedSectionId = sections[indexPath.row].0
                            }
                        }
                    }
                    sectionsTableView.deselectRowAtIndexPath(indexPath, animated: true)
                }
                break
            default:
                break
            }
        }
    }
}