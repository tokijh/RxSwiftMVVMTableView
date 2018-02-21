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
    
    lazy var sections: Observable<[TableViewSectionData]> = {
        return Observable<TableViewSectionData>.combineLatest([
            Observable.just(TableViewSectionData.firstSection),
            Observable.just(TableViewSectionData.secondSection),
            self.users.asObservable().map { TableViewSectionData.user(users: $0.map { TableViewSectionData.Value.user(user: $0) }) }
            ])
    }()
    
    lazy var dataSource: RxTableViewSectionedReloadDataSource<TableViewSectionData> = {
        return RxTableViewSectionedReloadDataSource(
            configureCell: { (dataSource, tableView, indexPath, row) -> UITableViewCell in
                switch dataSource[indexPath] {
                case .firstSection:
                    return tableView.dequeueReusableCell(withIdentifier: FirstSectionTableCell.Identifier, for: indexPath)
                case .secondSection:
                    return tableView.dequeueReusableCell(withIdentifier: SecondSectionTableCell.Identifier, for: indexPath)
                case .user(let user):
                    if let userCell = tableView.dequeueReusableCell(withIdentifier: UserTableCell.Identifier, for: indexPath) as? UserTableCell {
                        userCell.label.text = user.name
                        return userCell
                    }
                }
                return UITableViewCell()
        }, titleForHeaderInSection: { (dataSouece, section) -> String? in
            return "Header in \(section) Section"
        }, titleForFooterInSection: { (dataSource, section) -> String? in
            return "Footer in \(section) Section"
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
            loadUser()
        ]
    }
    
    func loadUser() -> Disposable {
        return Api.User.get().catchErrorJustReturn([]).subscribe(onNext: { [unowned self] in
            self.users.value = $0
        })
    }

    
    enum TableViewSectionData {
        case firstSection
        case secondSection
        case user(users: [Value])
    }
}

extension MainViewModel.TableViewSectionData: SectionModelType {
    
    typealias Item = Value
    
    var items: [Value] {
        switch self {
        case .firstSection:
            return [Value.firstSection]
        case .secondSection:
            return [Value.secondSection, Value.secondSection]
        case .user(let users):
            return users
        }
    }
    
    enum Value {
        case firstSection
        case secondSection
        case user(user: User)
    }
    
    init(original: MainViewModel.TableViewSectionData, items: [Value]) {
        switch original {
        case .firstSection:
            self = .firstSection
        case .secondSection:
            self = .secondSection
        case .user(_):
            self = .user(users: items)
        }
    }
}

