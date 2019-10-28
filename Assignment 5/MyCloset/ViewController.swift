//
//  ViewController.swift
//  MyCloset
//
//  Created by Aubrey Spannagel on 10/25/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var categories:[ClothingCategories] = []
    
    let context = DatabaseController.persistentStoreContainer().viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest:NSFetchRequest = ClothingCategories.fetchRequest()
        
        do{
            categories = try context.fetch(fetchRequest)
        }
        catch{
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
        cell?.textLabel?.text = categories[indexPath.row].categoryName
        return cell!}

   
}
