//
//  Todo.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ObjectMapper
import RxSwift

class Todo: Mappable {
    
    var title: String = ""
    
    required convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        title <- map["title"]
    }
}

extension Todo {
    open class func load(_ todos: Variable<[Todo]>) -> Disposable {
        return Api.Todo.get().catchErrorJustReturn([]).bind(to: todos)
    }
}
