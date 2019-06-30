//
//  File.swift
//  Notes
//
//  Created by ВЗБИВЕНЬ on 27/06/2019.
//  Copyright © 2019 ВЗБИВЕНЬ. All rights reserved.
//

import Foundation
import UIKit


enum Importance: String {
    case low
    case normal
    case high
    var rawValue: String {
        switch self {
        case .low: return "unimportant"
        case .normal: return "normal"
        case .high: return "important"
        }
    }
}

struct Note {
    let uid : String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let selfDestructionDate: Date?
    
    init(uid: String = UUID().uuidString,
         title: String,
         content: String,
         color: UIColor = UIColor.white,
         importance: Importance,
         selfDestructionDate: Date? = nil) {
        self.uid = uid
        self.title = title
        self.content = content
        self.color = color
        self.importance = importance
        self.selfDestructionDate = selfDestructionDate
    }
    
}
