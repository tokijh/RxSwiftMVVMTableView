//
//  Post.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ObjectMapper

class Post: Mappable {
    
    var title: String = ""
    
    required convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        title <- map["title"]
    }
}
