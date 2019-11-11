//
//  UICollectionViewFlowLayout+.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension UICollectionViewFlowLayout {
    func estimateWitdhOfCell(itemRow: CGFloat) -> CGFloat {
        return  (UIScreen.main.bounds.width - ((itemRow - 1)
            * self.minimumInteritemSpacing) - self.sectionInset.left
            - self.sectionInset.right) / itemRow
    }
}
