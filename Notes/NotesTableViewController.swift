//
//  NotesTableViewController.swift
//  Notes
//
//  Created by ВЗБИВЕНЬ on 18/07/2019.
//  Copyright © 2019 ВЗБИВЕНЬ. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    var notebook = FileNotebook()
    @objc func addNoteTaped(_ sender: Any) {
         performSegue(withIdentifier: "ShowEditNote", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Заметки"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNoteTaped(_:)))
        
        
        let note1 = Note(uid: "firstone", title: "Заголовок Один", content: "интересный текст", color: UIColor.blue, importance: .normal, selfDestructionDate: Date(timeIntervalSinceReferenceDate: 118800))
        let note2 = Note(title: "Заголовок Два", content: "кот съел собаку \n\n\n\nща невлезет\n\nмен не видно", importance: .high)
        notebook.add(note1)
        notebook.add(note2)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notebook.notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let note = notebook.notes[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.content
        cell.detailTextLabel?.numberOfLines = 5
        print(note.color)
        print(UIImage.from(color: note.color))
        cell.imageView?.image = UIImage.from(color: note.color)
        cell.imageView?.sizeToFit()
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        cell.imageView?.layer.borderWidth = 2

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notebook.remove(with: notebook.notes[indexPath.row].uid)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowEditNote", sender: indexPath.row)
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let selectedRow = sender as? Int
        let editController = segue.destination as? EditNote
        if let _ = selectedRow {
            editController?.note = notebook.notes[selectedRow!]
        } else {
            editController?.note = nil
        }
        editController?.mainViewController = self
    }
    func updateNotes(note: Note) {
        notebook.add(note, override: true)
        tableView.reloadData()
        print(notebook.notes)
    }
    

}
