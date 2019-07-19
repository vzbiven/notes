//
//  UIImageExtension.swift
//  Notes
//
//  Created by ВЗБИВЕНЬ on 18/07/2019.
//  Copyright © 2019 ВЗБИВЕНЬ. All rights reserved.
//
import UIKit
extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 20, height: 20)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
