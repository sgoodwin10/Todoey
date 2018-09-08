//
//  ViewController.swift
//  Todoey
//
//  Created by Samuel Goodwin on 8/9/18.
//  Copyright © 2018 Samuel Goodwin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find mike", "Buy eggs", "Go to school"]

    override func viewDidLoad() {
        super.viewDidLoad()
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
        // get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // add accessory
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        // turns off the seleted row background
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    //MARK: add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // alert popup
        let alert = UIAlertController(title: "Add New ITem", message: "", preferredStyle: .alert)
        
        // alert buttons
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item on our uialert
            
            self.itemArray.append( textField.text! )
            
            // update/reload the tableview
            self.tableView.reloadData()
        }
        
        // this creates the textfield to be used, before the popup, so popup will have textField access
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        // add action button to alert
        alert.addAction(action)
        
        
        
        present(alert, animated: true, completion: nil)
    }
}

