//
//  PlayVideoTrailerNavigator.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol PlayVideoTrailerNavigatorType {
    func back()
}

struct PlayVideoTrailerNavigator: PlayVideoTrailerNavigatorType {
    unowned let navigation: UINavigationController
    
    func back() {
        navigation.popViewController(animated: true)
    }
}
