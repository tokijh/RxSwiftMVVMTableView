//
//  TodoTableCellViewModel.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 27..
//  Copyright © 2018년 tokijh. All rights reserved.
//

struct TodoTableCellViewModel {
    
    let label: String
    
    init(todo: Todo) {
        self.label = todo.title
    }
}
