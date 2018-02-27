//
//  Post.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

class Post: Codable {
    
    var title: String = ""
    
}

extension Post {
    open class func load(_ posts: Variable<[Post]>) -> Disposable {
        return Api.Post.get().catchErrorJustReturn([]).bind(to: posts)
    }
}
