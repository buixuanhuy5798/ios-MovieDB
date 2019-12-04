//
//  RealmService.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

import RealmSwift
import RxRealm

struct RealmService {
    static let shared = RealmService()
    
    func getAllData<T: Object>(listOf: T.Type,
                               sortByKey: String? = nil,
                               filter: String? = nil) -> Observable<[T]> {
        do {
            var list = try Realm().objects(T.self)
            if let key = sortByKey {
                list = list.sorted(byKeyPath: key, ascending: false)
            }
            return Observable.array(from: list)
        } catch { }
        return Observable<[T]>.empty()
    }
}

