//
//  UIViewController+HideKeyboard.swift
//  Notes
//
//  Created by Александр Сафонов on 12/07/2019.
//  Copyright © 2019 Александр Сафонов. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
