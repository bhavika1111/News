//
//  Article.swift
//  News
//
//  Created by Bhavika Patel on 9/15/19.
//  Copyright © 2019 Bhavika Patel. All rights reserved.
//

import Foundation

struct Article : Decodable {
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?
}
