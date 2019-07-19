//
//  ColorPicker.swift
//  Notes
//
//  Created by Yaroslav on 7/7/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ColorPickerViewController2:UIViewController {
  
  var colorModel:ColorViewModel!
  
  @IBOutlet weak var colorPicker: ColorPicker!

  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    setupViews()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    colorPicker.tappedDoneHandler = { [weak self] in
      
      if let color = self?.colorPicker.rectSelectColor.backgroundColor,
         let brightless = self?.colorPicker.brightnessColorSlider.value
      {
        self?.colorModel.colorView = ColorView(color: color, brightless: brightless)
      }
      self?.dismiss(animated: true, completion: nil)
      
    }

  }
  
  func setupViews() {
    colorPicker.rectSelectColor.backgroundColor = colorModel.colorView.color
    colorPicker.brightnessColorSlider.value =  colorModel.colorView.brightless
    colorPicker.colorHexLable.text = "#\(colorModel.colorView.color.toHexString)"
  }
  
}

