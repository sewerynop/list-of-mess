//
//  TodoList.swift
//  List of mess
//
//  Created by Seweryn Kotowski on 11.09.2017.
//  Copyright © 2017 Seweryn Kotowski. All rights reserved.
//

import UIKit

class TodoList: NSObject {
    private let fileURL: NSURL = {
        let documentDirectoryURLs = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.appendingPathComponent("todolist.items") as NSURL
    }()
    
    var items: [String] = []
    
    override init(){
        super.init()
        loadItems()
    }

    func saveItems() {
        let itemsArray = items as NSArray
        
        print("Zapis elementow w \(fileURL)")
        if !itemsArray.write(to: fileURL as URL, atomically: true){
            print ("Nie udalo sie zapisac.")
        }
    }
    
    func loadItems() {
        if let itemsArray = NSArray(contentsOf: fileURL as URL) as? [String] {
        items = itemsArray
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.reloadData()
            saveItems()
        }
    }
    
    func addItem(item: String) {
        items.append(item)
        saveItems()
    }

}

extension TodoList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel!.text = item
        
        return cell
    }
    
}

