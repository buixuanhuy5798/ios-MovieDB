//
//  MovieCell.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/28/19.
//  Copyright © 2019 huy. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContentForCell(movieDetail: MovieShortenDetail) {
        nameLabel.text = movieDetail.title
        posterImageView.sd_setImage(with: URL(string: movieDetail.posterImageUrl))
    }
}
