//
//  MainViewModel.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxDataSources

class MainViewModel {
    
    let users = Variable<[User]>([])
    let todos = Variable<[Todo]>([])
    let posts = Variable<[Post]>([])
    
    lazy var sections: Observable<[TableViewSectionData]> = {
        return Observable<TableViewSectionData>.combineLatest([
            self.users.asObservable().map { TableViewSectionData.user(users: $0.map { TableViewSectionData.Value.user(user: $0) }) },
            self.todos.asObservable().map { TableViewSectionData.todo(todos: $0.map { TableViewSectionData.Value.todo(todo: $0) }) },
            self.posts.asObservable().map { TableViewSectionData.post(posts: $0.map { TableViewSectionData.Value.post(post: $0) }) }
            ])
    }()
    
    lazy var dataSource: RxTableViewSectionedReloadDataSource<TableViewSectionData> = {
        return RxTableViewSectionedReloadDataSource(
            configureCell: { (dataSource, tableView, indexPath, row) -> UITableViewCell in
                switch dataSource[indexPath] {
                case .user(let user):
                    if let userCell = tableView.dequeueReusableCell(withIdentifier: UserTableCell.Identifier, for: indexPath) as? UserTableCell {
                        userCell.label.text = user.name
                        return userCell
                    }
                case .todo(let todo):
                    if let todoCell = tableView.dequeueReusableCell(withIdentifier: TodoTableCell.Identifier, for: indexPath) as? TodoTableCell {
                        todoCell.label.text = todo.title
                        return todoCell
                    }
                case .post(let post):
                    if let postCell = tableView.dequeueReusableCell(withIdentifier: PostTableCell.Identifier, for: indexPath) as? PostTableCell {
                        postCell.label.text = post.title
                        return postCell
                    }
                }
                return UITableViewCell()
        }, titleForHeaderInSection: { (dataSouece, section) -> String? in
            switch section {
            case 0: return "Users"
            case 1: return "Todos"
            case 2: return "Posts"
            default:
                return nil
            }
        }, titleForFooterInSection: { (dataSource, section) -> String? in
            return nil
        }, canEditRowAtIndexPath: { (dataSource, indexPath) -> Bool in
            return true
        }, canMoveRowAtIndexPath: { (dataSource, indexPath) -> Bool in
            return true
        }, sectionIndexTitles: { (dataSource) -> [String]? in
            return nil
        }, sectionForSectionIndexTitle: { (dataSource, title, row) -> Int in
            return row
        })
    }()
    
    func configure() -> [Disposable] {
        return [
            loadUsers(),
            loadTodos(),
            loadPosts()
        ]
    }
    
    func loadUsers() -> Disposable {
        return Api.User.get().catchErrorJustReturn([]).subscribe(onNext: { [unowned self] in
            self.users.value = $0
        })
    }
    
    func loadTodos() -> Disposable {
        return Api.Todo.get().catchErrorJustReturn([]).subscribe(onNext: { [unowned self] in
            self.todos.value = $0
        })
    }
    
    func loadPosts() -> Disposable {
        return Api.Post.get().catchErrorJustReturn([]).subscribe(onNext: { [unowned self] in
            self.posts.value = $0
        })
    }
    
    enum TableViewSectionData {
        case user(users: [Value])
        case todo(todos: [Value])
        case post(posts: [Value])
    }
}

extension MainViewModel.TableViewSectionData: SectionModelType {
    
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
    
    init(original: MainViewModel.TableViewSectionData, items: [Value]) {
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

