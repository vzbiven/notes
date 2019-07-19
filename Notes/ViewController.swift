//
//  ViewController.swift
//  Notes
//
//  Created by Yaroslav on 6/24/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


  @IBOutlet weak var whiteView: ColorViewRect!
  @IBOutlet weak var redView: ColorViewRect!
  @IBOutlet weak var greenView: ColorViewRect!
  @IBOutlet weak var paleteView: ColorViewRect!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var stackViewColor: UIStackView!
  @IBOutlet weak var viewContainer: UIView!
  
  var kbFrameSize:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    print(stackViewColor.frame.maxX)
    print(stackViewColor.frame.maxY)
    print(kbFrameSize.height)
    scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: stackViewColor.frame.maxY + kbFrameSize.height + 10)
    scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    
    viewContainer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: stackViewColor.frame.maxY + kbFrameSize.height + 10)
    
  }
  
  @IBAction func tappedSwitch(_ sender: UISwitch) {
    datePicker.isHidden = !sender.isOn
  }
  
  var colorModel:ColorViewModel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    whiteView.layer.borderColor = UIColor.black.cgColor
    redView.layer.borderColor = UIColor.black.cgColor
    greenView.layer.borderColor = UIColor.black.cgColor
    paleteView.layer.borderColor = UIColor.black.cgColor

    whiteView.layer.borderWidth = 2
    redView.layer.borderWidth = 2
    greenView.layer.borderWidth = 2
    paleteView.layer.borderWidth = 2
  
    whiteView.touchesHandler = { [weak self] in
      self?.whiteView.isSelect = true
      self?.redView.isSelect = false
      self?.greenView.isSelect = false
      self?.paleteView.isSelect = false
    }
    
    redView.touchesHandler = { [weak self] in
      self?.whiteView.isSelect = false
      self?.redView.isSelect = true
      self?.greenView.isSelect = false
      self?.paleteView.isSelect = false
    }
    
    greenView.touchesHandler = { [weak self] in
      self?.whiteView.isSelect = false
      self?.redView.isSelect = false
      self?.greenView.isSelect = true
      self?.paleteView.isSelect = false
      
    }
    
    paleteView.touchesHandler = { [weak self] in
      self?.whiteView.isSelect = false
      self?.redView.isSelect = false
      self?.greenView.isSelect = false
      self?.paleteView.isSelect = true
      
    }
    
    paleteView.touchesLongHandler = { [weak self] in
      self?.performSegue(withIdentifier: "seguePalette", sender: self)
    }
    
    NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let colorPicker = segue.destination as? ColorPickerViewController {
      colorPicker.colorModel = colorModel
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if (colorModel != nil) {
      paleteView.isPallete = false
      paleteView.shapeColor = colorModel.colorView.color
      paleteView.alpha = CGFloat(colorModel.colorView.brightless)
      
      paleteView.isSelect = true
      whiteView.isSelect = false
      redView.isSelect = false
      greenView.isSelect = false
    } else {
       colorModel = ColorViewModel()
    }
    
  }
  

  @objc func kbDidShow(notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
    scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: stackViewColor.frame.maxY + kbFrameSize.height)
    scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    
  }
  
  @objc func kbDidHide() {
    scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: stackViewColor.frame.maxY)
  }
  
  
}

enum MyError: Error {
  
  case RuntimeError(message: String)
  
}

extension Double {
  
  func reverseSinus() throws -> Double {
    if (abs(self) < Double.ulpOfOne) {
      throw MyError.RuntimeError(message: "Could not evaluate reverse for zero value")
    }
    
    return sin(1 / self)
  }
  
}

