//
//  MainSectionData.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxDataSources

enum MainSectionData {
    case user(users: [Value])
    case todo(todos: [Value])
    case post(posts: [Value])
}

extension MainSectionData: SectionModelType {
    
    typealias Item = Value
    
    var items: [Value] {
        switch self {
        case .user(let users):
            return users
        case .todo(let todos):
            return todos
        case .post(let posts):
            return posts
        }
    }
    
    enum Value {
        case user(user: User)
        case todo(todo: Todo)
        case post(post: Post)
    }
    
    init(original: MainSectionData, items: [Value]) {
        switch original {
        case .user(_):
            self = .user(users: items)
        case .todo(_):
            self = .todo(todos: items)
        case .post(_):
            self = .post(posts: items)
        }
    }
}

