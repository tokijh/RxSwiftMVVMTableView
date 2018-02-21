//
//  DisposeBagExtension.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

extension DisposeBag {
    func insert(_ disposables: [Disposable]) {
        disposables.forEach { self.insert($0) }
    }
}
