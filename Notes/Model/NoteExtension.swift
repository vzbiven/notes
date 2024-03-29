//
//  NoteExtension.swift
//  Notes
//
//  Created by ВЗБИВЕНЬ on 27/06/2019.
//  Copyright © 2019 ВЗБИВЕНЬ. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    /// Convert RGBA color to integer value
    func toRGBA() -> NSArray {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return NSArray(array: [r, g, b, a])
    }
    
    /// Create RGBA UIColor from integer value
    static func fromRGBA(_ rgba: NSArray) -> UIColor? {
        let inner_rgba = rgba as Array
        guard inner_rgba.count == 4 else { return nil }
        let v = inner_rgba.map { $0 as! CGFloat }
        return UIColor(red: v[0], green: v[1], blue: v[2], alpha: v[3])
    }
}

extension Note {
    /// функция разбора json
    static func parse(json: [String: Any]) -> Note? {
        guard
            let uid = json["uid"] as? String,
            let title = json["title"] as? String,
            let content = json["content"] as? String,
            let colorRGBA = json["color"] as? NSArray?,
            let importanceRaw = json["importance"] as? String?,
            let selfDestructionDateDouble = json["selfDestructionDate"] as? Double?,
            // Lets convert json data to swift structures
            let color = UIColor.fromRGBA(colorRGBA ?? [1.0, 1.0, 1.0, 1.0]),
            let importance = Importance(rawValue: importanceRaw ?? Importance.normal.rawValue)
        else {
            return nil
        }
        let selfDestructionDate: Date? = selfDestructionDateDouble != nil ? Date(timeIntervalSince1970: selfDestructionDateDouble!) : nil
        
        return Note(
            uid: uid,
            title: title,
            content: content,
            color: color,
            importance: importance,
            selfDestructionDate: selfDestructionDate
        )
        
    }
    
    /// вычислимое значение формируещее json
    var json: [String: Any] {
        // format UIColor to HEX string
       
        var dict: [String: Any] = [
            "uid" : uid,
            "title" : title,
            "content" : content,
        ] // resulting dictionary
        // если цвет белый, то не пишем его в словарь
        if self.color != .white {
            dict["color"] = self.color.toRGBA()
        }
        // если важность нормальная, то ее тоже не записывем
        if self.importance != .normal {
            dict["importance"] = importance.rawValue
        }
        if let d = self.selfDestructionDate {
            dict["selfDestructionDate"] = d.timeIntervalSince1970
        }
        
        return dict
    }
}
