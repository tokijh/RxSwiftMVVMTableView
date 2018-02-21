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

class MainViewController: BaseViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FirstSectionTableCell.self, forCellReuseIdentifier: FirstSectionTableCell.Identifier)
        tableView.register(SecondSectionTableCell.self, forCellReuseIdentifier: SecondSectionTableCell.Identifier)
        tableView.register(UserTableCell.self, forCellReuseIdentifier: UserTableCell.Identifier)
        return tableView
    }()
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
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
    
    func initViewModel() {
        disposeBag.insert(self.viewModel.configure())
        self.viewModel.sections.bind(to: tableView.rx.items(dataSource: self.viewModel.dataSource)).disposed(by: disposeBag)
    }
    
}
