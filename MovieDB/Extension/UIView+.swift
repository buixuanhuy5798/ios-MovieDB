//
//  UIView+.swift
//  MyRoutine
//
//  Created by Bùi Xuân Huy on 8/16/19.
//  Copyright © 2019 huy. All rights reserved.
//

extension UIView {
    
    var height: CGFloat {
        return self.bounds.height
    }
    var witdh: CGFloat {
        return self.bounds.width
    }

    func overrideDraw(fillColor: UIColor, cornerTopLeft: Bool,
                      cornerTopRight: Bool, cornerBottomLeft: Bool,
                      cornerBottomRight: Bool, cornerRadius: CGFloat,
                      borderColor: UIColor, borderWidth: CGFloat,
                      rect: CGRect) {
        var cornerList = UIRectCorner()
        if cornerTopLeft {
            cornerList.insert(.topLeft)
        }
        if cornerTopRight {
            cornerList.insert(.topRight)
        }
        if cornerBottomLeft {
            cornerList.insert(.bottomLeft)
        }
        if cornerBottomRight {
            cornerList.insert(.bottomRight)
        }
        let roundedPath = UIBezierPath(roundedRect: CGRect(x: borderWidth / 2,
                                                           y: borderWidth / 2,
                                                           width: rect.width - borderWidth,
                                                           height: rect.height - borderWidth),
                                       byRoundingCorners: cornerList,
                                       cornerRadii: CGSize(width: cornerRadius,
                                                           height: cornerRadius))
        if !cornerTopLeft {
            roundedPath.move(to: CGPoint(x: 0,
                                         y: borderWidth / 2))
            roundedPath.addLine(to: CGPoint(x: borderWidth / 2,
                                            y: borderWidth / 2))
        }
        roundedPath.lineWidth = borderWidth
        borderColor.setStroke()
        roundedPath.stroke()
        fillColor.setFill()
        roundedPath.fill()
        roundedPath.addClip()
        roundedPath.close()
    }
    
}
