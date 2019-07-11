//
//  NotesTests.swift
//  NotesTests
//
//  Created by ВЗБИВЕНЬ on 30/06/2019.
//  Copyright © 2019 ВЗБИВЕНЬ. All rights reserved.
//

import XCTest
@testable import Notes

class NotesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNoteJson() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let note1 = Note(uid: "firstone", title: "title1", content: "content1", color: UIColor.blue, importance: .normal, selfDestructionDate: Date(timeIntervalSinceReferenceDate: 120))
        let notecopy1 = Note.parse(json: note1.json)!
        
        let note2 = Note(title: "title2", content: "content2", importance: .high)
        let notecopy2 = Note.parse(json: note2.json)!
        
        XCTAssertTrue(note1.uid == notecopy1.uid)
        XCTAssertTrue(note1.title == notecopy1.title)
        XCTAssertTrue(note1.content == notecopy1.content)
        XCTAssertTrue(note1.color == notecopy1.color)
        XCTAssertTrue(note1.importance == notecopy1.importance)
        XCTAssertTrue(note1.selfDestructionDate == notecopy1.selfDestructionDate)
        
        XCTAssertTrue(note2.uid == notecopy2.uid)
        XCTAssertTrue(note2.title == notecopy2.title)
        XCTAssertTrue(note2.content == notecopy2.content)
        XCTAssertTrue(note2.color.toRGBA() == notecopy2.color.toRGBA())
        XCTAssertTrue(note2.importance == notecopy2.importance)
        XCTAssertTrue(note2.selfDestructionDate == notecopy2.selfDestructionDate)
    }
    func testNoteFile() {
        let note1 = Note(uid: "firstone", title: "title1", content: "content1", color: UIColor.blue, importance: .normal, selfDestructionDate: Date(timeIntervalSinceReferenceDate: 120))
        let note2 = Note(title: "title2", content: "content2", importance: .high)
        
        
        let notebook = FileNotebook()
        notebook.add(note1)
        notebook.add(note2)
        notebook.saveToFile()
        
        let notebookCopy = FileNotebook()
        notebookCopy.add(note1)
        notebookCopy.add(note2)
        
        notebook.remove(with: note1.uid)
        notebook.remove(with: note2.uid)
        
        XCTAssertTrue(notebook.notes.count == 0)
        XCTAssertTrue(notebookCopy.notes.count == 2)
        
        notebook.loadFromFile()
        
        XCTAssertTrue(notebook.notes[0].uid == notebookCopy.notes[0].uid)
        XCTAssertTrue(notebook.notes[0].title == notebookCopy.notes[0].title)
        XCTAssertTrue(notebook.notes[0].content == notebookCopy.notes[0].content)
        XCTAssertTrue(notebook.notes[0].color.toRGBA() == notebookCopy.notes[0].color.toRGBA())
        XCTAssertTrue(notebook.notes[0].importance == notebookCopy.notes[0].importance)
        XCTAssertTrue(notebook.notes[0].selfDestructionDate == notebookCopy.notes[0].selfDestructionDate)
        
        XCTAssertTrue(notebook.notes[1].uid == notebookCopy.notes[1].uid)
        XCTAssertTrue(notebook.notes[1].title == notebookCopy.notes[1].title)
        XCTAssertTrue(notebook.notes[1].content == notebookCopy.notes[1].content)
        XCTAssertTrue(notebook.notes[1].color.toRGBA() == (notebookCopy.notes[1].color.toRGBA()))
        XCTAssertTrue(notebook.notes[1].importance == notebookCopy.notes[1].importance)
        XCTAssertTrue(notebook.notes[1].selfDestructionDate == notebookCopy.notes[1].selfDestructionDate)
        
    }

}
