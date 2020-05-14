//
//  ArticleModel.swift
//  News
//
//  Created by Bhavika Patel on 9/15/19.
//  Copyright © 2019 Bhavika Patel. All rights reserved.
//

import Foundation

protocol ArticleModelProtocol {
    func articlesRetrieved(_ articles:[Article])
}

class ArticleModel {

    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        
        
        // Create a string URL
        
        let stringURL =
        "https://newsapi.org/v2/everything?q=bitcoin&from=2020-04-14&sortBy=publishedAt&apiKey=42d654e1f2d7447584ae563abc03432b"
        
        // Create a URL object
        let url = URL(string: stringURL)
        
        // Check that it isn't nil
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        // Get the URL Session
        let session = URLSession.shared
        
        // Create the DataTask object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check if there's no error and that there is data
            if error == nil && data != nil {
                do {
                    // Decode the JSON data into our structs
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(ArticleService.self, from: data!)
                    
                    // Pass the articles back to the view controller
                    let articles = result.articles!
                    
                    // Do this on the main thread
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles)
                    }

                }
                catch {
                    print("Couldn't decode the json")
                    return
                }
            }
            
        }
        
        // Resume the task to fire off the request to the API
        dataTask.resume()

//        // When it returns, parse the JSON and pass the resulrs back to the
//        // view controller via protocol and delegate pattern
//        delegate?.articlesRetrieved([Article]())
    }
}
