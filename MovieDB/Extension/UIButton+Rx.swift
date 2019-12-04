//
//  UIButton+Rx.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension Reactive where Base: UIButton {
    var addedFavourite: Binder<Bool> {
        return Binder(base) { button, state in
            if state {
                button.setImage(#imageLiteral(resourceName: "icon_favorite_success"), for: .normal)
            } else {
                button.setImage(#imageLiteral(resourceName: "icon_add_favorite"), for: .normal)
            }
        }
    }
}
