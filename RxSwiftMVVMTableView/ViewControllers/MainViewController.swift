//
//  MainViewController.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxGesture

class MainViewController: BaseViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserTableCell.self, forCellReuseIdentifier: UserTableCell.Identifier)
        tableView.register(TodoTableCell.self, forCellReuseIdentifier: TodoTableCell.Identifier)
        tableView.register(PostTableCell.self, forCellReuseIdentifier: PostTableCell.Identifier)
        return tableView
    }()
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bind()
    }
    
    func initView() {
        appendSubViews()
        setConstraints()
    }
    
    func appendSubViews() {
        self.view.addSubview(self.tableView)
    }
    
    func setConstraints() {
        self.tableView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }
    
    func bind() {
        self.viewModel.sections.bind(to: tableView.rx.items(dataSource: self.dataSource)).disposed(by: disposeBag)
        self.viewModel.userCellResult.asDriver().drive(onNext: { [weak self] in
            switch $0 {
            case .none: break
            case .click(let user):
                self?.alert(title: "Click user", message: user.name)
            }
        }).disposed(by: disposeBag)
        self.viewModel.todoCellResult.asDriver().drive(onNext: { [weak self] in
            switch $0 {
            case .none: break
            case .click(let todo):
                self?.alert(title: "Click todo", message: todo.title)
            }
        }).disposed(by: disposeBag)
        self.viewModel.postCellResult.asDriver().drive(onNext: { [weak self] in
            switch $0 {
            case .none: break
            case .click(let post):
                self?.alert(title: "Click post", message: post.title)
            }
        }).disposed(by: disposeBag)
    }
    
    lazy var dataSource: RxTableViewSectionedReloadDataSource<MainSectionData> = { [unowned self] in
        return RxTableViewSectionedReloadDataSource(
            configureCell: { (dataSource, tableView, indexPath, row) -> UITableViewCell in
                switch dataSource[indexPath] {
                case .user(let user):
                    if let cell = tableView.dequeueReusableCell(withIdentifier: UserTableCell.Identifier, for: indexPath) as? UserTableCell {
                        cell.configure(viewModel: UserTableCellViewModel(user: user))
                        cell.label.rx.tapGesture().when(.recognized).subscribe { [weak self] _ in
                            self?.viewModel.userCellResult.value = .click(user: user)
                        }.disposed(by: cell.disposeBag)
                        return cell
                    }
                case .todo(let todo):
                    if let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableCell.Identifier, for: indexPath) as? TodoTableCell {
                        cell.configure(viewModel: TodoTableCellViewModel(todo: todo))
                        cell.label.rx.tapGesture().when(.recognized).subscribe { [weak self] _ in
                            self?.viewModel.todoCellResult.value = .click(todo: todo)
                        }.disposed(by: cell.disposeBag)
                        return cell
                    }
                case .post(let post):
                    if let cell = tableView.dequeueReusableCell(withIdentifier: PostTableCell.Identifier, for: indexPath) as? PostTableCell {
                        cell.configure(viewModel: PostTableCellViewModel(post: post))
                        cell.label.rx.tapGesture().when(.recognized).subscribe { [weak self] _ in
                            self?.viewModel.postCellResult.value = .click(post: post)
                        }.disposed(by: cell.disposeBag)
                        return cell
                    }
                }
                return UITableViewCell()
        }, titleForHeaderInSection: { (dataSouece, section) -> String? in
            switch section {
            case 0: return "Users"
            case 1: return "Todos"
            case 2: return "Posts"
            default: return nil
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
    
    func alert(title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
