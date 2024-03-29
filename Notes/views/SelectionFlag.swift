//
//  SelectionFlag.swift
//  Notes
//
//  Created by ВЗБИВЕНЬ on 12/07/2019.
//  Copyright © 2019 ВЗБИВЕНЬ. All rights reserved.
//

import UIKit

class SelectionFlag: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        // Drawing code
        let shapeColor: UIColor = .red
        shapeColor.setFill()
        let path = UIBezierPath()
        path.lineWidth = 3
        path.move(to: CGPoint(x: rect.minX + 3, y: rect.minY + 3))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - 3))
        path.addLine(to: CGPoint(x: rect.maxX - 3, y: rect.minY + 3))
        path.addLine(to: CGPoint(x: rect.maxX * 0.8, y: rect.minY + 3))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY * 0.7))
        path.addLine(to: CGPoint(x: rect.maxX * 0.4, y: rect.minY + 3))
        path.close()
        path.stroke()
        path.fill()

    }

}
