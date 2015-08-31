//
//  TopicsArticleViewController.swift
//  ubyssey
//
//  Created by Nathan Yee on 2015-07-27.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class TopicsArticleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var articlesTableView: UITableView!

    var refreshControl: UIRefreshControl!
    var articlesList:[Article] = []
    var paginationAdapter: TopicArticlesPaginationAdapter?
    var selectedTopicId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        var titleView = UIImageView(image: UIImage(named: "ubyssey_logo_small"))
        titleView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = titleView

        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.articlesTableView!.addSubview(refreshControl)

        paginationAdapter = TopicArticlesPaginationAdapter(api: UbysseyAPI(dataResolver: UbysseyAPIDataResolver()))
        // Do any additional setup after loading the view, typically from a nib.
        populateData()
    }

    func refresh() {
        populateData()
    }

    func populateData() {
        fetchArticles({(articles: [Article]) in
            self.articlesList.removeAll()
            for article in articles {
                self.articlesList.append(article)
            }
            if self.articlesList.count == 0 {
                // Create dummy "No articles found" article
                let jsonObject: JSON = ["long_headline": "No articles found"]
                self.articlesList.append(Article(articleData: jsonObject))
                self.articlesTableView.userInteractionEnabled = false
            } else {
                self.articlesTableView.userInteractionEnabled = true
            }
            self.articlesTableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:ArticleTableViewCell? = tableView.dequeueReusableCellWithIdentifier("TopicsArticleTableViewCell") as? ArticleTableViewCell
        cell?.setData(articlesList[indexPath.row])

        return cell!
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesList.count
    }

    func fetchArticles(callback: [Article] -> Void) {
        if selectedTopicId != nil {
            paginationAdapter!.getNext(callback, topicId: selectedTopicId!)
        }
    }

    override func viewDidAppear(animated: Bool) {
        self.articlesTableView.allowsSelection = true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.articlesTableView.allowsSelection = false
        if let identifier = segue.identifier {
            switch identifier {
            case "TopicsArticleDetailSegue":
                let indexPath = articlesTableView.indexPathForSelectedRow()
                let viewController = segue.destinationViewController as! TopicsArticleDetailViewController
                viewController.article = articlesList[indexPath!.row]
                articlesTableView.deselectRowAtIndexPath(indexPath!, animated: true)
                break
            default:
                break
            }
        }
    }
}
