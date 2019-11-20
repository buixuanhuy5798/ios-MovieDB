//
//  NowPlayingCell.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/8/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class NowPlayingCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        configViews()
    }
    
    private func configViews() {
        posterImageView.setConerRadius(conerRadius: 10)
    }
    
    func setContentCell(nowPlaying: NowPlaying) {
        titleLabel.text = nowPlaying.title
        posterImageView.sd_setImage(with: URL(string: nowPlaying.urlImage))
    }
}
