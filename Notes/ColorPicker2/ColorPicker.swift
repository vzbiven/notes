//
//  ColorPicker.swift
//  Notes
//
//  Created by Yaroslav on 7/11/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

@IBDesignable
class ColorPicker:UIView {
  
  @IBOutlet weak var viewColorConteiner: UIView!
  @IBOutlet weak var rectSelectColor: UIView!
  @IBOutlet weak var colorHexLable: UILabel!
  @IBOutlet weak var brightnessColorSlider: UISlider!
  @IBOutlet weak var paletteColor: HSBColorPicker!
  
  @IBAction func changedBrightnessColorSlider(_ sender: UISlider) {
    let step: Float = 0.05
    let roundedValue = round(sender.value / step) * step
    sender.value = roundedValue
    
    rectSelectColor.alpha = CGFloat(brightnessColorSlider.value)

    //brightnessColorSlider.value = //Float(colorModel.colorView.brightless)
    //viewColor.alpha = CGFloat(colorModel.colorView.brightless)
    //viewColor.backgroundColor = colorModel.colorView.color
    //hexColor.text = "#\(colorModel.colorView.color.toHexString)"

  }
  @IBAction func tappedOnDone(_ sender: UIButton) {
    tappedDoneHandler?()
  }
  
  var tappedDoneHandler: (() -> Void)?
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }
  
  private func setupViews() {
    let xibView = loadViewFromXib()
    xibView.frame = self.bounds
    xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.addSubview(xibView)
    
    viewColorConteiner.layer.cornerRadius = 5
    viewColorConteiner.layer.borderColor = UIColor.black.cgColor
    viewColorConteiner.layer.borderWidth = 1
    
    rectSelectColor.layer.cornerRadius = 5
    rectSelectColor.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    rectSelectColor.layer.borderColor = UIColor.black.cgColor
    rectSelectColor.layer.borderWidth = 1
    
    paletteColor.layer.borderColor = UIColor.black.cgColor
    paletteColor.layer.borderWidth = 1
    
    paletteColor.delegate = self as HSBColorPickerDelegate
  }
  
  private func loadViewFromXib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "ColorPicker", bundle: bundle)
    
    return nib.instantiate(withOwner: self, options: nil).first! as! UIView
  }
}

extension ColorPicker:HSBColorPickerDelegate {
  func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State) {
    rectSelectColor.backgroundColor = color
    colorHexLable.text = "#\(color.toHexString)"
  }

}
