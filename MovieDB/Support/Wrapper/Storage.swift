//
//  Storage.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/27/19.
//  Copyright © 2019 huy. All rights reserved.
//


@propertyWrapper
struct Storage<T> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
