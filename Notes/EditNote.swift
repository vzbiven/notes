//
//  ViewController.swift
//  Notes
//
//  Created by Александр Сафонов on 04/07/2019.
//  Copyright © 2019 Александр Сафонов. All rights reserved.
//

import UIKit

class EditNote: UIViewController {
    
    var note: Note?
    var mainViewController: NotesTableViewController?
    
    @IBOutlet weak var colorOneView: ColorPaneView!
    @IBOutlet weak var colorTwoView: ColorPaneView!
    @IBOutlet weak var colorThreeView: ColorPaneView!
    @IBOutlet weak var colorSelectableView: ColorPaneView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var datePickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var datePickerSwitch: UISwitch!
    
    private var screenSize: CGRect? = nil
    private let datePickerHeight: CGFloat = 200.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainViewController?.updateNotes(note: createNote())
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        dismissKeyboard()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if screenSize == nil {
            screenSize = view.bounds
        }
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let screenSize = screenSize{
            let newFrame = CGRect(origin: screenSize.origin, size: CGSize(width: screenSize.width, height: screenSize.height - keyboardSize.height))
            view.frame = newFrame
        }
        view.setNeedsLayout()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let size = screenSize {
            view.frame = size
            screenSize = nil
        }
    }
    
    @IBAction func onDestroyDateSwitched(_ sender: UISwitch) {
        datePickerHeightConstraint.constant = sender.isOn ? datePickerHeight : 0.0
        if sender.isOn {
            self.datePicker.isHidden = false
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            if !sender.isOn {
                self.datePicker.isHidden = true
            }
        }
    }
    @IBAction func onCustomColorSelection(_ sender: UILongPressGestureRecognizer) {
        dismissKeyboard()
        print("DA EBAL YA")
        performSegue(withIdentifier: "ShowColorPicker", sender: nil)
    }
    
    @IBAction func onColorSelection(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            let loc = sender.location(in: view)
            if let subview = view.hitTest(loc, with: nil) as? ColorPaneView,
                let _ = subview.Color{
                resetColorSelection()
                subview.Selected = true
            }
        }
    }
    
    private func setupUI() {
        colorOneView.Color = UIColor.white.cgColor
        colorOneView.Selected = true
        colorTwoView.Color = UIColor.green.cgColor
        colorThreeView.Color = UIColor.blue.cgColor
        noteTextView.placeholder = "Start entering note here"
        
        if let note = note {
            noteTitle.text = note.title
            noteTextView.text = note.content
            if let date = note.selfDestructionDate {
                datePickerSwitch.isOn = true
                datePicker.isHidden = false
                datePickerHeightConstraint.constant = datePickerHeight
                datePicker.date = date
            }
            colorSelectableView.Color = note.color.cgColor
            resetColorSelection()
            colorSelectableView.Selected = true
        }
/*
        colorPicker.onCompletedSelection = { color in
            self.colorSelectableView.Color = color
            self.resetColorSelection()
            self.colorSelectableView.Selected = true
        }
 */
        hideKeyboardWhenTappedAround()
    }
    
    private func resetColorSelection() {
        colorOneView.Selected = false
        colorTwoView.Selected = false
        colorThreeView.Selected = false
        colorSelectableView.Selected = false
    }
    
    private func createNote() -> Note {
        // если будет пустой тайтл или текст то все навернется
        let newUid: String? = note?.uid
        let newTitle = noteTitle.text
        let newContent = noteTextView.text
        
        var newColor: UIColor? = nil
        for palleteCell in [colorOneView, colorTwoView, colorThreeView, colorSelectableView] {
            if palleteCell!.Selected {
                newColor = UIColor(cgColor: palleteCell!.Color!)
            }
        }
        
        let newImportance = note?.importance
        
        let newSelfDestructionDate: Date?
        if datePickerSwitch.isOn {
            newSelfDestructionDate = datePicker.date
        } else {
             newSelfDestructionDate = note?.selfDestructionDate
        }
        
        let newNote = Note(uid: newUid ?? UUID().uuidString, title: newTitle!, content: newContent!, color: newColor!, importance: newImportance ?? Importance(rawValue: "normal")!, selfDestructionDate: newSelfDestructionDate)
        return newNote
    }


}
