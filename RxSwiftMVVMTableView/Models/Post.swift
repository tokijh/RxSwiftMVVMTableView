//
//  Post.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ObjectMapper
import RxSwift

class Post: Mappable {
    
    var title: String = ""
    
    required convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        title <- map["title"]
    }
}

extension Post {
    open class func load(_ posts: Variable<[Post]>) -> Disposable {
        return Api.Post.get().catchErrorJustReturn([]).bind(to: posts)
    }
}
