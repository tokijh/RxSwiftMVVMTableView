//
//  MainViewModel.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxCocoa

protocol MainViewModelType: BaseViewModelType {
    // Event
    var viewWillAppear: PublishSubject<Void> { get }
    var didSelectCell: PublishSubject<MainSectionData.Value> { get }
    
    // Value
    var users: BehaviorRelay<[User]> { get }
    var posts: BehaviorRelay<[Post]> { get }
    var todos: BehaviorRelay<[Todo]> { get }
    
    // UI
    var sections: Driver<[MainSectionData]> { get }
    var showAlert: Driver<(String, String)> { get }
}

class MainViewModel: MainViewModelType {
    var disposeBag = DisposeBag()
    
    // Event
    let viewWillAppear = PublishSubject<Void>()
    let didSelectCell = PublishSubject<MainSectionData.Value>()
    
    // Value
    let users = BehaviorRelay<[User]>(value: [])
    let posts = BehaviorRelay<[Post]>(value: [])
    let todos = BehaviorRelay<[Todo]>(value: [])
    
    // UI
    let sections: Driver<[MainSectionData]>
    let showAlert: Driver<(String, String)>
    
    init(service: MainServiceType = MainService()) {
        
        let users = self.users
        let posts = self.posts
        let todos = self.todos
        
        self.viewWillAppear
            .flatMap { service.requestUsers().catchErrorJustReturn([]) }
            .bind(to: users)
            .disposed(by: disposeBag)
        
        self.viewWillAppear
            .flatMap { service.requestPosts().catchErrorJustReturn([]) }
            .bind(to: posts)
            .disposed(by: disposeBag)
        
        self.viewWillAppear
            .flatMap { service.requestTodos().catchErrorJustReturn([]) }
            .bind(to: todos)
            .disposed(by: disposeBag)
        
        self.sections = Observable<MainSectionData>
            .combineLatest([
                users.asObservable().map { MainSectionData.user(users: $0.map { MainSectionData.Value.user(user: $0) }) },
                todos.asObservable().map { MainSectionData.todo(todos: $0.map { MainSectionData.Value.todo(todo: $0) }) },
                posts.asObservable().map { MainSectionData.post(posts: $0.map { MainSectionData.Value.post(post: $0) }) }
            ])
            .asDriver(onErrorJustReturn: [])
        
        self.showAlert = Observable<(String, String)>
            .merge([
                didSelectCell.map({
                    switch $0 {
                    case .user(let user): return ("User", user.name)
                    case .post(let post): return ("Post", post.title)
                    case .todo(let todo): return ("Todo", todo.title)
                    }
                })
            ])
            .asDriver(onErrorJustReturn: ("Error", "Unknown Error"))
    }
}
