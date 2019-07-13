//
//  HSBView.swift
//  Notes
//

import UIKit

@IBDesignable
class HSBView: UIView {
    
    private var sizeX: CGFloat = 0
    private var sizeY: CGFloat = 0
    private var pointSizeX: CGFloat = 0
    private var pointSizeY: CGFloat = 0
    public var brightness: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private(set) var currentColor = UIColor.gray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        sizeX = frame.width
        sizeY = frame.height
        pointSizeX = sizeX / 360.0
        pointSizeY = sizeY / 100.0
        for x: CGFloat in stride(from: 0.0, to: sizeX, by: pointSizeX) {
            for y: CGFloat in stride(from: 0.0, to: sizeY, by: pointSizeY) {
                let color = UIColor(hue: x / sizeX,
                                    saturation: 1.0 - y / sizeY,
                                    brightness: brightness,
                                    alpha: 1.0)
                context.setFillColor(color.cgColor)
                // width * 2 and height * 2 to prevent black lines
                context.fill(CGRect(x: x, y: y, width: pointSizeX * 2.0, height: pointSizeY * 2.0))
            }
        }
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            currentColor = UIColor(hue: position.x / sizeX,
                                   saturation: 1.0 - position.y / sizeY,
                                   brightness: brightness,
                                   alpha: 1.0)
        }
    }
}

