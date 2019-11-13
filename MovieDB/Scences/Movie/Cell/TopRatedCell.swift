//
//  TopRatedCell.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/11/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class TopRatedCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var backdropImage: UIImageView!
    
    override func layoutSubviews() {
        backdropImage.addGradientBackground(firstColor: .clear,
                                            secondColor: .black)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configViews()
    }
    
    func configViews() {
        backdropImage.setConerRadius(conerRadius: 10)
    }
    
    func setContentCell(topRated: TopRated) {
        titleLabel.text = topRated.title
        backdropImage.sd_setImage(with: URL(string: API.APIUrl.backdropUrl + topRated.backdropPath))
    }

}
