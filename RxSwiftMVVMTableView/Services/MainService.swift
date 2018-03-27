//
//  MainService.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 3. 27..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

protocol MainServiceType {
    func requestUsers() -> Observable<[User]>
    func requestPosts() -> Observable<[Post]>
    func requestTodos() -> Observable<[Todo]>
}

class MainService: MainServiceType {
    func requestUsers() -> Observable<[User]> {
        return Api.User.get()
    }
    
    func requestPosts() -> Observable<[Post]> {
        return Api.Post.get()
    }
    
    func requestTodos() -> Observable<[Todo]> {
        return Api.Todo.get()
    }
}
