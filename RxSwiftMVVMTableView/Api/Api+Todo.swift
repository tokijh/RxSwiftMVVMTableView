//
//  Api+Todo.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxAlamofire
import ObjectMapper

extension Api {
    final class Todo {
        open class func get() -> Observable<[RxSwiftMVVMTableView.Todo]> {
            return json(.get, "\(Api.baseUrl)/todos")
                .debug()
                .mapArray(type: RxSwiftMVVMTableView.Todo.self)
        }
    }
}
