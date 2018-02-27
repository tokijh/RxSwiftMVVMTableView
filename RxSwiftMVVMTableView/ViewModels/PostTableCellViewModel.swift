//
//  PostTableCellViewModel.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 27..
//  Copyright © 2018년 tokijh. All rights reserved.
//

struct PostTableCellViewModel {
    
    let label: String
    
    init(post: Post) {
        self.label = post.title
    }
}
