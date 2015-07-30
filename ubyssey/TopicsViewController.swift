//
//  TopicsViewController.swift
//  ubyssey
//
//  Created by Nathan Yee on 2015-07-27.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var topicsTableView: UITableView!

    // Int: id of topic
    // String: name of topic
    //
    // Invarient: no id has the same name as another id
    var topics: [(Int, String)] = []

    override func viewDidLoad() {
        var titleView = UIImageView(image: UIImage(named: "ubyssey_logo_small"))
        titleView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = titleView

        populateSections()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = topics[indexPath.row].1
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Do not run tableView.deselectRowAtIndexPath(indexPath, animated: false) here
        // since prepareForSegue relies on the row still being selected to set the
        // selectedSection of the destination TopicsArticleViewController

        self.performSegueWithIdentifier("TopicsArticleViewControllerSegue", sender: self)
    }

    func populateSections() {
        let api = UbysseyAPI(dataResolver: UbysseyAPIDataResolver())
        api.getTopics { (data: JSON) -> Void in
            for (index: String, topic: JSON) in data["results"] {
                self.topics.append(topic["id"].intValue, topic["name"].stringValue)
            }
            self.topicsTableView.reloadData()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "TopicsArticleViewControllerSegue":
                if let indexPath = topicsTableView.indexPathForSelectedRow() {
                    let viewController = segue.destinationViewController as! TopicsArticleViewController
                    if let cell = topicsTableView.cellForRowAtIndexPath(indexPath) {
                        if let cellLabel = cell.textLabel {
                            if let cellLabelText = cellLabel.text {
                                // NOTE: This loop may do the wrong thing if
                                // more than one id in topics have the same
                                // name (the smallest id will be chosen)
                                for pair in topics {
                                    if pair.1 == cellLabelText {
                                        viewController.selectedTopicId = pair.0
                                    }
                                }
                            }
                        }
                    }
                    topicsTableView.deselectRowAtIndexPath(indexPath, animated: true)
                }
                break
            default:
                break
            }
        }
    }
}
