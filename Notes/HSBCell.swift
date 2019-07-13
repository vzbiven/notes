//
//  ColorCellView.swift
//  Notes
//
//  Created by Artyom Gurbovich on 7/12/19.
//  Copyright © 2019 Test Organization. All rights reserved.
//

import UIKit

@IBDesignable
class HSBCell: UIView {
    
    override func draw(_ rect: CGRect) {

            let context = UIGraphicsGetCurrentContext()!
            let sizeX = frame.width
            let sizeY = frame.height
            let pointSizeX = sizeX / 360.0
            let pointSizeY = sizeY / 100.0
            for x: CGFloat in stride(from: 0.0, to: sizeX, by: pointSizeX) {
                for y: CGFloat in stride(from: 0.0, to: sizeY, by: pointSizeY) {
                    let color = UIColor(hue: x / sizeX,
                                        saturation: 1.0 - y / sizeY,
                                        brightness: 1.0,
                                        alpha: 1.0)
                    context.setFillColor(color.cgColor)
                    // width * 2 and height * 2 to prevent black lines
                    context.fill(CGRect(x: x, y: y, width: pointSizeX * 2.0, height: pointSizeY * 2.0))
                }
            }
    }
}
