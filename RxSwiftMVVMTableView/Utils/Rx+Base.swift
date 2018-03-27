//
//  Rx+Base.swift
//  CocoaLibrary
//
//  Created by tokijh on 2018. 3. 20..
//  Copyright © 2018년 tokijh. All rights reserved.
//
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
    var viewWillAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillAppear)).map { _ in }
        return ControlEvent(events: source)
    }
    var viewDidAppear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidAppear)).map { _ in }
        return ControlEvent(events: source)
    }
    var viewWillDisappear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewWillDisappear)).map { _ in }
        return ControlEvent(events: source)
    }
    var viewDidDisappear: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidDisappear)).map { _ in }
        return ControlEvent(events: source)
    }
}
