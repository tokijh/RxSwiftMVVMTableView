//
//  User.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 21..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import ObjectMapper
import RxSwift

class User: Mappable {
    
    var name: String = ""
    
    required convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        name <- map["name"]
    }
}

extension User {
    open class func load(_ users: Variable<[User]>) -> Disposable {
        return Api.User.get().catchErrorJustReturn([]).bind(to: users)
    }
}
