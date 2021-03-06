//
//  Api+User.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxAlamofire
import ObjectMapper

extension Api {
    final class User {
        open class func get() -> Observable<[RxSwiftMVVMTableView.User]> {
            return json(.get, "\(Api.baseUrl)/users")
                .debug()
                .mapArray(type: RxSwiftMVVMTableView.User.self)
        }
    }
}
