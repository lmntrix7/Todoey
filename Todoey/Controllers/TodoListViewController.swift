//
//  ViewController.swift
//  Todoey
//
//  Created by Rajat Jain on 14/07/18.
//  Copyright © 2018 Rajat Jain. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let defaults = UserDefaults.standard 
     var itemArray = [Item]()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let newItem = Item()
        newItem.title = "budum"
        itemArray.append(newItem)
        
        
        let newItem2 = Item()
        newItem2.title = "dudum"
        itemArray.append(newItem2)
        
        
        
        let newItem3 = Item()
        newItem3.title = "doggo"
        itemArray.append(newItem3)
        
        
        
       if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
            }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text=item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
       
        return cell 
    }
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    tableView.reloadData()
    
   
    tableView.deselectRow(at: indexPath, animated: true)
    
    }
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        
       let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen when user clicks + button
            print(textField.text!)
            print("Success")
            let newItem = Item()
            newItem .title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    
    
    }
    
    
}

