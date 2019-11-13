//
//  CollectionViewLayout.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/12/19.
//  Copyright © 2019 huy. All rights reserved.
//

struct CollectionViewLayout {
    var itemsSpacing: CGFloat
    var itemsPerRow: Float
    var sectionInset: UIEdgeInsets
    
    init(itemSpacing: CGFloat, itemsPerRow: Float) {
        self.itemsSpacing = itemSpacing
        self.itemsPerRow = itemsPerRow
        self.sectionInset = UIEdgeInsets(
            top: 0,
            left: 7,
            bottom: 0,
            right: 7)
    }
    
    func estimateWitdhPerItems() -> CGFloat {
        let screenSize = UIScreen.main.bounds
        let paddingSpace = sectionInset.left
            + sectionInset.right
            + CGFloat(itemsPerRow - 1) * itemsSpacing
        let availableWitdh = screenSize.width - paddingSpace
        return availableWitdh / CGFloat(itemsPerRow)
    }
}
