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
    
    var showDateFlag = false
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var scrollbottomalign: NSLayoutConstraint!
    @IBOutlet weak var datePickerHeight: NSLayoutConstraint!
    @IBAction func showDateSwitch(_ sender: UISwitch) {
        if showDateFlag {
            datePickerHeight.constant = 0
            showDateFlag = !showDateFlag
        } else {
            datePickerHeight.constant = 300
            showDateFlag = !showDateFlag
        }
        
    }
    
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var palette1: UIView!
    @IBOutlet weak var palette2: UIView!
    @IBOutlet weak var palette3: UIView!
    @IBOutlet weak var palette4: UIView!
    
    @IBOutlet weak var flag1: SelectionFlag!
    @IBOutlet weak var flag2: SelectionFlag!
    @IBOutlet weak var flag3: SelectionFlag!
    @IBOutlet weak var flag4: SelectionFlag!
    
    @IBOutlet weak var HSBCell: HSBCell!
    @IBOutlet weak var colorPicker: ColorPicker!
    
    @IBAction func palette1tapped(_ sender: UITapGestureRecognizer) {
        noteText.textColor = palette1.backgroundColor
        flag1.isHidden = false
        flag2.isHidden = true
        flag3.isHidden = true
        flag4.isHidden = true
        
    }

    @IBAction func palette2tapped(_ sender: UITapGestureRecognizer) {
        noteText.textColor = palette2.backgroundColor
        flag1.isHidden = true
        flag2.isHidden = false
        flag3.isHidden = true
        flag4.isHidden = true
    }
    
    @IBAction func palette3tapped(_ sender: UITapGestureRecognizer) {
        noteText.textColor = palette3.backgroundColor
        flag1.isHidden = true
        flag2.isHidden = true
        flag3.isHidden = false
        flag4.isHidden = true
    }
    
    @IBAction func palette4tapped(_ sender: UITapGestureRecognizer) {
        palette4.backgroundColor = colorPicker.currentColor
        noteText.textColor = palette4.backgroundColor
        flag1.isHidden = true
        flag2.isHidden = true
        flag3.isHidden = true
        flag4.isHidden = false
    }

    
    @IBAction func pelette4longPress(_ sender: UILongPressGestureRecognizer) {
        colorPicker.isHidden = false
        HSBCell.isHidden = true
        flag1.isHidden = true
        flag2.isHidden = true
        flag3.isHidden = true
        flag4.isHidden = false
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            
            if self.colorPicker.isHidden {
                self.palette4.backgroundColor = self.colorPicker.currentColor
                self.noteText.textColor = self.palette4.backgroundColor
                timer.invalidate()
                
            }
        }
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if scrollbottomalign.constant == 0 {
                scrollbottomalign.constant += keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if scrollbottomalign.constant != 0 {
            scrollbottomalign.constant = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        datePickerHeight.constant = 0
        palette1.backgroundColor = UIColor.black
        palette1.layer.borderWidth = 3
        palette1.layer.borderColor = UIColor.black.cgColor
        
        palette2.backgroundColor = UIColor.blue
        palette2.layer.borderWidth = 3
        palette2.layer.borderColor = UIColor.black.cgColor
        
        palette3.backgroundColor = UIColor.brown
        palette3.layer.borderWidth = 3
        palette3.layer.borderColor = UIColor.black.cgColor
        
        palette4.layer.borderWidth = 3
        palette4.layer.borderColor = UIColor.black.cgColor
        

        //textView.translatesAutoresizingMaskIntoConstraints = true
        //textView.sizeToFit()
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
