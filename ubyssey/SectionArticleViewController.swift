//
//  SectionArticleViewController.swift
//  ubyssey
//
//  Created by Nathan Yee on 2015-07-08.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class SectionArticleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var articlesTableView: UITableView!
    var refreshControl:UIRefreshControl!

    var articlesList:[Article] = []
    var paginationAdapter: PaginationAdapter?
    var selectedSection: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        var titleView = UIImageView(image: UIImage(named: "ubyssey_logo_small"))
        titleView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationItem.titleView = titleView

        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.articlesTableView!.addSubview(refreshControl)

        paginationAdapter = PaginationAdapter(api: UbysseyAPI(dataResolver: UbysseyAPIDataResolver()))
        // Do any additional setup after loading the view, typically from a nib.
        populateData()
    }

    func refresh() {
        populateData()
    }

    func populateData() {
        fetchArticles({(articles: [Article]) in
            self.articlesList.removeAll()
            if self.selectedSection != nil {
                for article in articles {
                    if article.section == self.selectedSection {
                        self.articlesList.append(article)
                    }
                }
                self.articlesTableView.reloadData()
            }
            self.refreshControl.endRefreshing()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:ArticleTableViewCell? = tableView.dequeueReusableCellWithIdentifier("SectionArticleTableViewCell") as? ArticleTableViewCell
        cell?.setData(articlesList[indexPath.row])

        return cell!
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesList.count
    }

    func fetchArticles(callback: [Article] -> Void) {
        paginationAdapter!.getNext(callback)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "SectionArticleDetailSegue":
                let indexPath = articlesTableView.indexPathForSelectedRow()
                let viewController = segue.destinationViewController as! SectionArticleDetailViewController
                viewController.article = articlesList[indexPath!.row]
                articlesTableView.deselectRowAtIndexPath(indexPath!, animated: true)
                break
            default:
                break
            }
        }
    }
}
