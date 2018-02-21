//
//  Api+Post.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxAlamofire
import ObjectMapper

extension Api {
    final class Post {
        open class func get() -> Observable<[RxSwiftMVVMTableView.Post]> {
            return json(.get, "\(Api.baseUrl)/posts")
                .debug()
                .mapArray(type: RxSwiftMVVMTableView.Post.self)
        }
    }
}
