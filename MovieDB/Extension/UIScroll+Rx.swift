//
//  UIScroll+Rx.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 10/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension Reactive where Base: UIScrollView {
    var customScrollBinding: Binder<CGFloat> {
        return Binder(base) { scrollView, addXOffset  in
            scrollView.contentOffset.x += addXOffset
        }
    }
}
