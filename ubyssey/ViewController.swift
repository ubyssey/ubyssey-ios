//
//  ViewController.swift
//  ubyssey
//
//  Created by Chris Zhu on 2015-04-06.
//  Copyright (c) 2015 ca.ubyssey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var articlesTableView: UITableView!
    
    var articlesList:[Article] = []
    var paginationAdapter: PaginationAdapter?
    override func viewDidLoad() {
        super.viewDidLoad()
        paginationAdapter = PaginationAdapter(api: UbysseyAPI(dataResolver: UbysseyAPIDataResolver()))
        fetchArticles({(articles: [Article]) in
            for article in articles {
                self.articlesList.append(article)
            }
            
            self.articlesTableView.reloadData()
        })
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:ArticleTableViewCell? = tableView.dequeueReusableCellWithIdentifier("ArticleTableViewCell") as? ArticleTableViewCell
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
            case "ArticleDetailSegue":
                let indexPath = articlesTableView.indexPathForSelectedRow()
                let viewController = segue.destinationViewController as! ArticleDetailViewController
                viewController.article = articlesList[indexPath!.row]
                break
            default:
                break
            }
        }
    }

}

