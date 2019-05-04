//
//  ViewController.swift
//  Todoey
//
//  Created by Rajat Jain on 14/07/18.
//  Copyright © 2018 Rajat Jain. All rights reserved.
//

import UIKit
import RealmSwift


class TodoListViewController: UITableViewController {
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    

   override func viewDidLoad() {
    
    super.viewDidLoad()
    
    
       print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist"))
       

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text=item.title
            
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        }
        else{
            cell.textLabel?.text = "No Items"
        }
        
       
        return cell 
    }
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(todoItems?[indexPath.row])
    
    if let items = todoItems?[indexPath.row]{
        do{
       try self.realm.write {
            items.done = !items.done
        
        }
    }
        catch{
            print("Error updating realm")
        }
    }
    
  //  todoItems?[indexPath.row].done = !todoItems?[indexPath.row].done
 //  self.saveItems()
    
   
    tableView.deselectRow(at: indexPath, animated: true)
    tableView.reloadData()
    }
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        
       let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen when user clicks + button
            print(textField.text!)
            print("Success")
            
           

            if let currentCategory = self.selectedCategory{
                do{
                try self.realm.write {
                    let newItem = Item()
                    newItem .title = textField.text!
                    currentCategory.items.append(newItem)
                    
                }
                }
            
             catch{
                print("Error saving items")
                }
                
            }
        }
    
        
    
    
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
    
    
    
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    tableView.reloadData()
    }
    
    func loadItems(){
todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
  self.tableView.reloadData()
    }
    
    
}
    



// MARK: - Search bar methods

extension TodoListViewController : UISearchBarDelegate{


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        
    }
    

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

    }
}
}



    
    
    
    
    
    
    
    
    
    
    
    
    
    


