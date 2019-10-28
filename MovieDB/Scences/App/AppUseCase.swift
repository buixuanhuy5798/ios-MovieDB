//
//  AppUseCase.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/24/19.
//  Copyright © 2019 huy. All rights reserved.
//

protocol AppUseCaseType {
    func changeCheckFirstLauch()
}

struct AppUseCase: AppUseCaseType {
    func changeCheckFirstLauch() {
        AppData.firstLaunch = false
    }
}
