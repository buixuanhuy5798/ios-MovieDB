//
//  CategoriesCell.swift
//  MovieDB
//
//  Created by Bùi Xuân Huy on 11/22/19.
//  Copyright © 2019 huy. All rights reserved.
//

final class CategoriesCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        backgroundImageView.setConerRadius(conerRadius: 10)
    }
    
    func setContentForCell(category: Category) {
        nameLabel.text = category.name
    }
}
