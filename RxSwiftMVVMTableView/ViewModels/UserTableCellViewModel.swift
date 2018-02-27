//
//  UserTableCellViewModel.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 26..
//  Copyright © 2018년 tokijh. All rights reserved.
//

struct UserTableCellViewModel {
    
    let label: String
    
    init(user: User) {
        self.label = user.name
    }
}
