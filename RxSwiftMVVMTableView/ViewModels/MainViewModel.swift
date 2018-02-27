//
//  MainViewModel.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

class MainViewModel {
    
    let users = BehaviorRelay<[User]>(value: [])
    let todos = BehaviorRelay<[Todo]>(value: [])
    let posts = BehaviorRelay<[Post]>(value: [])
    
    let userCellResult = BehaviorRelay<UserCellResult>(value: .none)
    let todoCellResult = BehaviorRelay<TodoCellResult>(value: .none)
    let postCellResult = BehaviorRelay<PostCellResult>(value: .none)
    
    let disposeBag = DisposeBag()
    
    init() {
        load()
    }
    
    func load() {
        User.load(self.users).disposed(by: disposeBag)
        Todo.load(self.todos).disposed(by: disposeBag)
        Post.load(self.posts).disposed(by: disposeBag)
    }
    
    lazy var sections: Observable<[MainSectionData]> = {
        return Observable<MainSectionData>.combineLatest([
            self.users.asObservable().map { MainSectionData.user(users: $0.map { MainSectionData.Value.user(user: $0) }) },
            self.todos.asObservable().map { MainSectionData.todo(todos: $0.map { MainSectionData.Value.todo(todo: $0) }) },
            self.posts.asObservable().map { MainSectionData.post(posts: $0.map { MainSectionData.Value.post(post: $0) }) }
            ])
    }()
    
    enum UserCellResult {
        case none
        case click(user: User)
    }
    
    enum TodoCellResult {
        case none
        case click(todo: Todo)
    }
    
    enum PostCellResult {
        case none
        case click(post: Post)
    }
}
