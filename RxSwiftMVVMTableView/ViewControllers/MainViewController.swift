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

class MainViewController: UIViewController, BaseViewType {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserTableCell.self, forCellReuseIdentifier: UserTableCell.Identifier)
        tableView.register(TodoTableCell.self, forCellReuseIdentifier: TodoTableCell.Identifier)
        tableView.register(PostTableCell.self, forCellReuseIdentifier: PostTableCell.Identifier)
        return tableView
    }()
    
    var viewModel: MainViewModelType!
    var disposeBag: DisposeBag!
    
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
    
    func bindEvent() {
        tableView.rx.modelSelected(MainSectionData.Value.self).bind(to: viewModel.didSelectCell).disposed(by: disposeBag)
        rx.viewWillAppear.bind(to: viewModel.viewWillAppear).disposed(by: disposeBag)
    }
    
    func bindView() {
        viewModel.sections.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        viewModel.showAlert
            .drive(onNext: { [weak self] in
                self?.alert(title: $0.0, message: $0.1)
            })
            .disposed(by: disposeBag)
    }
    
    lazy var dataSource: RxTableViewSectionedReloadDataSource<MainSectionData> = { [unowned self] in
        return RxTableViewSectionedReloadDataSource(
            configureCell: { (dataSource, tableView, indexPath, row) -> UITableViewCell in
                switch dataSource[indexPath] {
                case .user(let user):
                    if let cell = tableView.dequeueReusableCell(withIdentifier: UserTableCell.Identifier, for: indexPath) as? UserTableCell {
                        cell.configure(label: user.name)
                        return cell
                    }
                case .todo(let todo):
                    if let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableCell.Identifier, for: indexPath) as? TodoTableCell {
                        cell.configure(label: todo.title)
                        return cell
                    }
                case .post(let post):
                    if let cell = tableView.dequeueReusableCell(withIdentifier: PostTableCell.Identifier, for: indexPath) as? PostTableCell {
                        cell.configure(label: post.title)
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
