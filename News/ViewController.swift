//
//  ViewController.swift
//  News
//
//  Created by Bhavika Patel on 9/15/19.
//  Copyright © 2019 Bhavika Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Create a new article Model
    var model = ArticleModel()
    var articles = [Article]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Conform to the tableview protocols
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get the articles for the article model
        model.delegate = self
        model.getArticles()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the article which the user tapped on
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            print("User didn't select an article")
            return
        }
        let article = articles[indexPath!.row]
        // Get a reference to the DetailViewController
        let detailVC =  segue.destination as! DetailViewController

        // Set the articleUrl property to the DetailViewController
        detailVC.articleUrl = article.url
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of articles
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell

        // Get article that the tableview is trying to display
        let article = articles[indexPath.row]

        // Customize it
        cell.displayArticle(article)
        
        // Return that cell
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Transition to the detail view and pass the article that was selected
        performSegue(withIdentifier: "SegueToDetail", sender: self)
    }
}

extension ViewController: ArticleModelProtocol {
    func articlesRetrieved(_ articles: [Article]) {

        self.articles = articles
        tableView.reloadData()
    }
    
    
}
