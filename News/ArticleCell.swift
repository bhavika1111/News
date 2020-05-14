//
//  ArticleCell.swift
//  News
//
//  Created by Bhavika Patel on 9/18/19.
//  Copyright © 2019 Bhavika Patel. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    
    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay: Article?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func displayArticle(_ article:Article) {
        
        // Clear the imageview (in case this cell is being reused)
        articleImageView.image = nil
        
        // Hold a reference to the article
        articleToDisplay = article
        
        // Display the headline
        headlineLabel.text = articleToDisplay!.title!
        
        // Download the article image
        // Check if the article has an image
        let urlString = articleToDisplay!.urlToImage
        
        guard urlString != nil else {
            return
        }
        
        // Before we go and download the image, check if it's in the cache
        let cachedData = CacheManager.retrieveImageData(urlString!)
        
        if cachedData != nil {
            // If the cached data exists, use that instead
            articleImageView.image = UIImage(data: cachedData!)
            return
        }
        
        // Create url object
        let url = URL(string: urlString!)
        
        // Check that it isn't nil
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        // Get the session
        let session = URLSession.shared
    
        // Create the datatask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there's no error and that there is data
            if error == nil && data != nil {
                
                // Save the image data to cache
                CacheManager.saveImageData(urlString!, data!)
                
                // Before we set the image, ensure that this image data is still relevant to the article
                if self.articleToDisplay?.urlToImage == urlString! {
                    // Set the imageView with the data
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: data!)
                    }
                }

            }
        }
        
        // Fire the datatask
        dataTask.resume()
    }
}
