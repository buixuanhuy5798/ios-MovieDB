//
//  ActorCell.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/25/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class ActorCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var actorNameLabel: UILabel!
    @IBOutlet private weak var avaImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContentForCell(actor: Actor) {
        actorNameLabel.text = actor.name
        avaImageView.sd_setImage(with: URL(string: actor.avatarUrl))
    }
}
