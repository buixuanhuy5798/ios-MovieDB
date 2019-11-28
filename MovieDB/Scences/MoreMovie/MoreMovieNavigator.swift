//
//  MoreMovieNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol MoreMovieNavigatorType {
    func back()
}

struct MoreMovieNavigator: MoreMovieNavigatorType {
    unowned let navigation: UINavigationController
    
    func back() {
        navigation.popViewController(animated: true)
    }
}
