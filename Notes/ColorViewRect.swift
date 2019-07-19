//
//  ColorViewRect.swift
//  Notes
//
//  Created by Yaroslav on 7/6/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

@IBDesignable
class ColorViewRect: UIView {
  
  let saturationExponentTop:Float = 2.0
  let saturationExponentBottom:Float = 1.3
  
  @IBInspectable var elementSize: CGFloat = 1.0 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var shapeColor: UIColor = .white {
    didSet {
      //viewConteiner.backgroundColor = shapeColor
      setNeedsDisplay()
    }
  }
  @IBInspectable var shapePosition: CGPoint = .zero {
    didSet {
      setNeedsDisplay()
    }
  }
  @IBInspectable var shapeSize:CGSize = CGSize(width: 64, height: 64) {
    didSet {
      setNeedsDisplay()
    }
  }
  @IBInspectable var isSelect: Bool = false {
    didSet {
      setNeedsDisplay()
    }
  }
  
  @IBInspectable var isPallete:Bool = false {
    didSet {
      setNeedsDisplay()
    }
  }
  
  var viewConteiner:UIView = {
    let view = UIView()
    //view.backgroundColor = UIColor.green
    view.translatesAutoresizingMaskIntoConstraints = false
    return view;
  }()
  
  private func initialize() {
    
    //self.viewConteiner.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
    //self.viewConteiner.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
    
    //self.addSubview(viewConteiner)
    self.clipsToBounds = true
    
    let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed(gestureRecognizer:)))
    longPressRecognizer.minimumPressDuration = 0.5
    longPressRecognizer.allowableMovement = CGFloat.greatestFiniteMagnitude

    self.addGestureRecognizer(longPressRecognizer)
  
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  var touchesHandler: (() -> Void)?
  var touchesLongHandler: (() -> Void)?
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    shapeColor.setFill()
    let path = getPathRect(in: CGRect(origin: shapePosition, size: shapeSize))
    path.fill()
  
    if isPallete {
      drawPalette(rect)
    }
    
    if isSelect {
      drawCheckMarkInsideView()
    }
    
  }
  
  private func getPathRect(in rect: CGRect) -> UIBezierPath {
    let path = UIBezierPath()
    path.lineWidth = 0
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
    path.addLine(to: CGPoint(x:rect.maxY, y:rect.minX))
    path.addLine(to: CGPoint(x:rect.maxY, y:rect.maxX))
    path.addLine(to: CGPoint(x: rect.minY, y: rect.maxX))
    path.close()
    path.stroke()
    path.fill()
    return path
  }
  
  private func drawPalette(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()
    for y : CGFloat in stride(from: 0.0 ,to: rect.height, by: elementSize) {
      var saturation = y < rect.height / 2.0 ? CGFloat(2 * y) / rect.height : 2.0 * CGFloat(rect.height - y) / rect.height
      saturation = CGFloat(powf(Float(saturation), y < rect.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
      let brightness = y < rect.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect.height - y) / rect.height
      for x : CGFloat in stride(from: 0.0 ,to: rect.width, by: elementSize) {
        let hue = x / rect.width
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        context!.setFillColor(color.cgColor)
        context!.fill(CGRect(x:x, y:y, width:elementSize,height:elementSize))
      }
    }
  }
  private func drawCheckMarkInsideView()
  {
    //// Oval Drawing
    let ovalPath = UIBezierPath(ovalIn: CGRect(x: 40, y: 10, width: 20, height: 20))
    UIColor.black.setStroke()
    ovalPath.lineWidth = 2
    ovalPath.stroke()
    
    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: 44.5, y: 18.72))
    bezierPath.addCurve(to: CGPoint(x: 50.5, y: 26.5), controlPoint1: CGPoint(x: 50.5, y: 26.5), controlPoint2: CGPoint(x: 50.5, y: 26.5))
    bezierPath.addLine(to: CGPoint(x: 56.5, y: 12.5))
    UIColor.black.setStroke()
    bezierPath.lineWidth = 2
    bezierPath.stroke()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    isSelect = true
    setNeedsDisplay()
    touchesHandler?()
  }
  
  @objc func longPressed(gestureRecognizer: UILongPressGestureRecognizer)
  {
    if(gestureRecognizer.state == UIGestureRecognizer.State.began) {
      touchesLongHandler?()
      print("longpressed")
    }
  }
  

  
  
//  bezierPath.move(to: CGPoint(x: 54.5, y: 18.72))
//  bezierPath.addCurve(to: CGPoint(x: 60.5, y: 26.5), controlPoint1: CGPoint(x: 60.5, y: 26.5), controlPoint2: CGPoint(x: 60.5, y: 26.5))
//  bezierPath.addLine(to: CGPoint(x: 66.5, y: 12.5))
}

