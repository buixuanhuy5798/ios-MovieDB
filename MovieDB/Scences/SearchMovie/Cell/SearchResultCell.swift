//
//  SearchResultCell.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/27/19.
//  Copyright © 2019 huy. All rights reserved.
//

import UIKit

final class SearchResultCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var bounderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bounderView.setConerRadius(conerRadius: 10)
    }
    
    func setContentForCell(movieDetail: MovieDetail) {
        overviewLabel.text = movieDetail.overview
        voteAverageLabel.text = "\(movieDetail.voteAverage)"
        titleLabel.text = movieDetail.title
        posterImageView.sd_setImage(with: URL(string: movieDetail.posterImageUrl))
    }
    
}
