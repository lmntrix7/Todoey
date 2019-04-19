//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Rajat Jain on 25/07/18.
//  Copyright © 2018 Rajat Jain. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
loadCategories()
    }
 // Mark : - TableView Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",for : indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
     // Mark : - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        
            
        }
    }
    
    
    
    
    
    
    
    // Mark : - Data manipulation
    func saveCategories(){
        do{
            try context.save()
        }
        catch{
            print("Error saving cat,\(error)")
        }
        tableView.reloadData()
    }
    
    
    func loadCategories(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try context.fetch(request)
        }
        catch{
            print("Error loading cat,\(error)")
        }
        tableView.reloadData()
    }
    
    
    
    // Mark : - Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            print(textField.text!)
            print("Succes adding category")
            
            let newCategory = Category(context: self.context)
        newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            self.saveCategories()
            
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new category"
        }
        present(alert,animated: true,completion: nil)
        
    }
   
    
    
    
    
   
    
    
    
    
   
    
    
    
    
}



