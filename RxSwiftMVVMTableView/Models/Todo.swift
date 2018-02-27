//
//  Todo.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

class Todo: Codable {
    
    var title: String = ""
    
}

extension Todo {
    open class func load(_ todos: Variable<[Todo]>) -> Disposable {
        return Api.Todo.get().catchErrorJustReturn([]).bind(to: todos)
    }
}
