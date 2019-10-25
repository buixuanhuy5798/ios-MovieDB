//
//  ShadowButton.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/5/19.
//  Copyright © 2019 huy. All rights reserved.
//

@IBDesignable
class RoundedButton: UIButton {

    /// MARK: - Inspectable
    @IBInspectable var fillColor: UIColor = .white
    @IBInspectable var cornerTopLeft: Bool = true
    @IBInspectable var cornerTopRight: Bool = true
    @IBInspectable var cornerBottomLeft: Bool = true
    @IBInspectable var cornerBottomRight: Bool = true
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        layer.masksToBounds = false
        backgroundColor = .clear
    }
    
    // MARK: - Drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        overrideDraw(fillColor: fillColor,
                     cornerTopLeft: cornerTopLeft,
                     cornerTopRight: cornerTopRight,
                     cornerBottomLeft: cornerBottomLeft,
                     cornerBottomRight: cornerBottomRight,
                     cornerRadius: cornerRadius,
                     borderColor: borderColor,
                     borderWidth: borderWidth,
                     rect: rect)
    }
    
}
