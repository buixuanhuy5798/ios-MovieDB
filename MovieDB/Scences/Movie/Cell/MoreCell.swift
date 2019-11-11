//
//  MoreCell.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class MoreCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var moreImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customCell()
    }
    
    func customCell() {
        moreImage.setConerRadius(conerRadius: 10)
    }
}
