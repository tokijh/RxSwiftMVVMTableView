//
//  User.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

class User: Codable {
    
    var name: String = ""
    
}

extension User {
    open class func load(_ users: Variable<[User]>) -> Disposable {
        return Api.User.get().catchErrorJustReturn([]).bind(to: users)
    }
}
