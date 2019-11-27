//
//  UIImage+Rx.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/26/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension Reactive where Base: UIImageView {

    var imageUrl: Binder<String> {
        return Binder(base) { imageView, imageUrl in
            imageView.sd_setImage(with: URL(string: imageUrl))
        }
    }
}

