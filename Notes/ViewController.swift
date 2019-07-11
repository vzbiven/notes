//
//  ViewController.swift
//  Notes
//
//  Created by ВЗБИВЕНЬ on 30/06/2019.
//  Copyright © 2019 ВЗБИВЕНЬ. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /**
        let note1 = Note(uid: "firstone", title: "title1", content: "content1", color: UIColor.blue, importance: .normal, selfDestructionDate: Date(timeIntervalSinceReferenceDate: 118800))
        
        let note2 = Note(title: "title2", content: "content2", importance: .high)
        
        print(note1)
        print(note1.json)
        print(note2.json)
        
        let note3: Note? = Note.parse(json: note1.json)
        print(note3!)
        print(note3!.json)
        
        let notebook = FileNotebook()
        notebook.add(note3!)
        notebook.add(note1)
        notebook.add(note2)
        DDLogVerbose(String(notebook.notes.count))
        notebook.saveToFile()
        notebook.remove(with: "firstone")
        DDLogVerbose(String(notebook.notes.count))
        notebook.loadFromFile()
        DDLogVerbose("Notes:")
        for note in notebook.notes {
            print(note)
        }
        
        var a = [Any]()
        for _ in 0..<100000 {
            a.append(a)
        }
        //
        //for num in 1..<100000 {
        //   let num_sin = sin(Double(1 / num))
        //    DDLogVerbose(String(num_sin))
        /} **/
        
    }

}
