//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Rajat Jain on 25/07/18.
//  Copyright © 2018 Rajat Jain. All rights reserved.
//

import UIKit

import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var categories : Results<Category>?
  

    override func viewDidLoad() {
        super.viewDidLoad()
     loadCategories()
    }
 // Mark : - TableView Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",for : indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
        return cell
    }
    
     // Mark : - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        
            
        }
    }
    
    
    
    
    
    
    
    // Mark : - Data manipulation
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("Error saving cat,\(error)")
        }
        tableView.reloadData()
    }
    
    
    func loadCategories(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    
    // Mark : - Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            print(textField.text!)
            print("Succes adding category")
            
            let newCategory = Category()
        newCategory.name = textField.text!
            
          
            self.save(category: newCategory)
            
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new category"
        }
        present(alert,animated: true,completion: nil)
        
    }
   
    
    
    
    
   
    
    
    
    
   
    
    
    
    
}



