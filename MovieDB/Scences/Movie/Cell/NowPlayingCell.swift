//
//  NowPlayingCell.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/8/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class NowPlayingCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        configViews()
    }
    
    private func configViews() {
        posterImage.setConerRadius(conerRadius: 10)
    }
    
    func setContentCell(nowPlaying: NowPlaying) {
        titleLabel.text = nowPlaying.title
        posterImage.sd_setImage(with: URL(string: API.APIUrl.backdropUrl + nowPlaying.posterPath))
    }
}
