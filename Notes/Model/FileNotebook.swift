//
//  FileNotebook.swift
//  Notes
//
//  Created by ВЗБИВЕНЬ on 27/06/2019.
//  Copyright © 2019 ВЗБИВЕНЬ. All rights reserved.
//

import Foundation
import UIKit

/// реализация записной книжки
class FileNotebook {
    /// закрытая для внешнего изменения, но открытая для получения коллекция
    private(set) var notes: [Note] = []
    
    /// функцияя добавленияя новой заметки
    public func add(_ note: Note) {
        // проверка на дубликаты
        if let _ = notes.first(where: {$0.uid == note.uid}) {
            print("Запись с таким uid уже существует!")
        } else {
            self.notes.append(note)
            print("Запись добавлена")
        }
    }
    
    /// функция удаления заметки на основе uid
    public func remove(with uid: String) {
        self.notes.removeAll(where: { $0.uid == uid })
    }

    /// функция сохранения всей записной книжки в файл
    public func saveToFile() {
        let dirURL = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("notebook")
        let fileURL = dirURL?.appendingPathComponent("n.json")
        
        do {
            try FileManager.default.createDirectory(
                at: dirURL!,
                withIntermediateDirectories: true,
                attributes: nil
            )
        } catch {
            print("Cant create directory")
        }
        //формируем массив из json
        let note_jsons: [[String: Any]] = self.notes.map { $0.json }
        //записываем в файл
        do {
            let data = try JSONSerialization.data(withJSONObject: note_jsons)
            FileManager.default.createFile(atPath: fileURL!.absoluteString, contents: data)
            try data.write(to: fileURL!)
        } catch {
            print("Невозможно создать файл")
        }
    }
    
    /// функция загрузки записной книжки из файла
    public func loadFromFile() {
        let dirURL = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("notebook")
        guard let fileURL = dirURL?.appendingPathComponent("n.json")
            else { return }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let arr = try JSONSerialization.jsonObject(with: data, options: [])
            as! [[String: Any]] //Array<Dictionary<String, Any>>
            //формируем массив из json
            for obj in arr {
                if let note = Note.parse(json: obj) {
                    self.add(note)
                }
            }
        } catch {
            print("Невозможно прочитать файл")
        }
    }
}


