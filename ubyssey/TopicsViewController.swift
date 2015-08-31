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
    var refreshControl: UIRefreshControl!

    // Int: id of topic
    // String: name of topic
    //
    // Invarient: no id has the same name as another id
    var topics: [(Int, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        var titleView = UIImageView(image: UIImage(named: "ubyssey_logo_small"))
        titleView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = titleView

        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.topicsTableView.addSubview(refreshControl)
        self.topicsTableView.separatorStyle = UITableViewCellSeparatorStyle.None

        populateTopics()
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
        // selectedTopicId of the destination TopicsArticleViewController

        self.performSegueWithIdentifier("TopicsArticleViewControllerSegue", sender: self)
    }

    func refresh() {
        populateTopics()
    }

    func populateTopics() {
        self.topics.removeAll()
        let api = UbysseyAPI(dataResolver: UbysseyAPIDataResolver())
        api.getTopics { (data: JSON) -> Void in
            for (index: String, topic: JSON) in data["results"] {
                self.topics.append(topic["id"].intValue, topic["name"].stringValue)
            }
            self.topicsTableView.reloadData()
            self.refreshControl.endRefreshing()
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
                                // NOTE: this assumes that every row number
                                // of topicsTableView corresponds to the order
                                // of every topic in topics (in ascending
                                // order)
                                viewController.selectedTopicId = topics[indexPath.row].0
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
