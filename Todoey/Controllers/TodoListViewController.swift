//
//  ViewController.swift
//  Todoey
//
//  Created by Samuel Goodwin on 8/9/18.
//  Copyright © 2018 Samuel Goodwin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()

    // persistent data
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append( newItem )
        
        let newItem2 = Item()
        newItem2.title = "Find Sammy"
        itemArray.append( newItem2 )
        
        let newItem3 = Item()
        newItem3.title = "Find Dacve"
        itemArray.append( newItem3 )
        // if userdefault not exist, app will crash
//        itemArray = defaults.array(forKey: "TodoListArray") as! [String]
        // lets check first
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
        // get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // update accessory based on the item.done bool
        cell.accessoryType = item.done ? .checkmark : .none
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // add accessory
        // the ! does the oppposite of the boolean
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        if itemArray[indexPath.row].done == false {
//           itemArray[indexPath.row].done = true
//        }
//        else {
//            itemArray[indexPath.row].done = false
//        }
        
        // reloads the data
        tableView.reloadData()
        
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append( newItem )
            
            // set user default
            self.defaults.set( self.itemArray, forKey: "TodoListArray")
            
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

