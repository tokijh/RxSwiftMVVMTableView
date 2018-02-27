//
//  RxAlamofire+Codable.swift
//  RxSwiftMVVMTableView
//
//  Created by tokijh on 2018. 2. 26..
//  Copyright © 2018년 tokijh. All rights reserved.
//

import RxSwift

extension ObservableType {
    public func mapObject<T: Codable>(type: T.Type) -> Observable<T> {
        return flatMap { (data) -> Observable<T> in
            if let data = (data as? (HTTPURLResponse, Data))?.1 {
                return try self.mapObject(type: type, data: data)
            } else if let json = (data as? (HTTPURLResponse, Any))?.1 {
                return try self.mapObjectJSON(type: type, json: json)
            } else {
                return try self.mapObjectJSON(type: type, json: data)
            }
        }
    }
    
    public func mapArray<T: Codable>(type: T.Type) -> Observable<[T]> {
        return flatMap { (data) -> Observable<[T]> in
            if let data = (data as? (HTTPURLResponse, Data))?.1 {
                return try self.mapArray(type: type, data: data)
            } else if let json = (data as? (HTTPURLResponse, Any))?.1 {
                return try self.mapArrayJSON(type: type, json: json)
            } else {
                return try self.mapArrayJSON(type: type, json: data)
            }
        }
    }
    
    public func mapObject<T: Codable>(type: T.Type, data: Data) throws -> Observable<T> {
        let decoder = JSONDecoder()
        let object = try decoder.decode(T.self, from: data)
        return Observable.just(object)
    }
    
    public func mapArray<T: Codable>(type: T.Type, data: Data) throws -> Observable<[T]> {
        let decoder = JSONDecoder()
        let objects = try decoder.decode([T].self, from: data)
        return Observable.just(objects)
    }
    
    public func mapObjectData<T: Codable>(type: T.Type) -> Observable<T> {
        return flatMap { data -> Observable<T> in
            guard let data = (data as? (HTTPURLResponse, Data))?.1 else { throw self.throwDecodingError() }
            return try self.mapObject(type: type, data: data)
        }
    }
    
    public func mapArrayData<T: Codable>(type: T.Type) -> Observable<[T]> {
        return flatMap { data -> Observable<[T]> in
            guard let data = (data as? (HTTPURLResponse, Data))?.1 else { throw self.throwDecodingError() }
            return try self.mapArray(type: type, data: data)
        }
    }
    
    public func mapObjectJSON<T: Codable>(type: T.Type) -> Observable<T> {
        return flatMap { json -> Observable<T> in
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return try self.mapObject(type: type, data: data)
        }
    }
    
    public func mapObjectJSON<T: Codable>(type: T.Type, json: Any) throws -> Observable<T> {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        return try self.mapObject(type: type, data: data)
    }
    
    public func mapArrayJSON<T: Codable>(type: T.Type) -> Observable<[T]> {
        return flatMap { json -> Observable<[T]> in
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return try self.mapArray(type: type, data: data)
        }
    }
    
    public func mapArrayJSON<T: Codable>(type: T.Type, json: Any) throws -> Observable<[T]> {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        return try self.mapArray(type: type, data: data)
    }
    
    public func mapObjectRequestJSON<T: Codable>(type: T.Type) -> Observable<T> {
        return flatMap { json -> Observable<T> in
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return try self.mapObject(type: type, data: data)
        }
    }
    
    public func mapArrayRequestJSON<T: Codable>(type: T.Type) -> Observable<[T]> {
        return flatMap { requestJSON -> Observable<[T]> in
            guard let json = (requestJSON as? (HTTPURLResponse, Any))?.1 else { throw self.throwDecodingError() }
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return try self.mapArray(type: type, data: data)
        }
    }
    
    private func throwDecodingError() -> NSError {
        return NSError(
            domain: "",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Codable can't decoding"]
        )
    }
}
