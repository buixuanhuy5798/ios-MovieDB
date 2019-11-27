//
//  MovieDetailNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MovieDetailNavigatorType {
    func back()
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    unowned let navigation: UINavigationController
    
    func back() {
        navigation.popViewController(animated: true)
    }
}
