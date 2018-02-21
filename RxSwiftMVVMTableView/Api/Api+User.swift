//
//  Api+User.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift
import RxAlamofire

extension Api {
    final class User {
        open class func get() -> Observable<[RxSwiftMVVMTableView.User]> {
            
            let user1 = RxSwiftMVVMTableView.User()
            user1.name = "user1"
            let user2 = RxSwiftMVVMTableView.User()
            user2.name = "user2"
            let user3 = RxSwiftMVVMTableView.User()
            user3.name = "user3"
            let user4 = RxSwiftMVVMTableView.User()
            user4.name = "user4"
            let user5 = RxSwiftMVVMTableView.User()
            user5.name = "user5"
            let user6 = RxSwiftMVVMTableView.User()
            user6.name = "user6"
            
            return Observable.just([
                user1,
                user2,
                user3,
                user4,
                user5,
                user6,
            ])
//            return json(.get, Api.baseUrl + "?results=20")
//                .debug()
//                .map({
//                    print($0)
//                    let user = RxSwiftTableViewExample.User()
//                    user.name = "hi"
//                    return [user]
//                })
//                .mapArray(type: RxSwiftTableViewExample.User.self)
        }
    }
}

