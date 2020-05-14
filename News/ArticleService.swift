//
//  ArticleService.swift
//  News
//
//  Created by Bhavika Patel on 9/15/19.
//  Copyright © 2019 Bhavika Patel. All rights reserved.
//

import Foundation

struct ArticleService : Decodable {
    
    var totalResults:Int?
    var articles:[Article]?
}
