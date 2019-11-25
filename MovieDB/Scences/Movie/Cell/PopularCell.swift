//
//  PopularCell.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/18/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class PopularCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var scoreView: UIView!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        posterImageView.setConerRadius(conerRadius: 10)
        scoreView.setConerRadius(conerRadius: scoreView.height / 2)
    }
    
    func setContentCell(popular: Popular) {
        titleLabel.text = popular.title
        scoreLabel.text = "\(popular.voteAverage)"
        posterImageView.sd_setImage(with: URL(string: popular.urlImage))
    }
}
