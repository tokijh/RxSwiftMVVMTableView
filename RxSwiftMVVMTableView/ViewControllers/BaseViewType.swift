//
//  ViewControllerType.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 3. 26..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import UIKit
import RxSwift

protocol BaseViewType: class {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
    var disposeBag: DisposeBag! { get set }
    func initView()
    func bindEvent()
    func bindView()
}

extension BaseViewType where Self: UIViewController {
    static func create(with viewModel: ViewModel) -> Self {
        let `self` = Self()
        
        self.viewModel = viewModel
        self.disposeBag = DisposeBag()
        
        self.loadViewIfNeeded()
        self.loadView()
        
        self.view.backgroundColor = UIColor.white // Set default VC background color
        
        self.initView()
        self.bindEvent()
        self.bindView()
        
        return self
    }
}
