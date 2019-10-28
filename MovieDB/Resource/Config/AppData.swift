//
//  AppData.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct AppData {
    
    struct Constants {
        static let keyCheckFirstLaunch = "FirstLauchApp"
    }
    
    @Storage(key: Constants.keyCheckFirstLaunch, defaultValue: true)
    static var firstLaunch: Bool
    
}
