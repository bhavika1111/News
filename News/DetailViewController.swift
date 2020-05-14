//
//  DetailViewController.swift
//  News
//
//  Created by Bhavika Patel on 9/15/19.
//  Copyright © 2019 Bhavika Patel. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check if there's a url, if there is, then display it
        
        if articleUrl != nil {
            
            // Create a url object
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                return
            }
            
            // Create a request
            let request = URLRequest(url: url!)
            
            // Load the request
            webView.load(request)
        }
    }

}
