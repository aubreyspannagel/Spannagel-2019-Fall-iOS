//
//  tableViewController.swift
//  MyCloset
//
//  Created by Aubrey Spannagel on 10/27/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import CoreData


class tableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let getCellInfo = DatabaseController.persistentStoreContainer().viewContext
        
        let fetchRequest:NSFetchRequest = ClothingCategories.fetchRequest()
        
        do{
            categories = try getCellInfo.fetch(fetchRequest)
        }
        catch{
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
        cell?.textLabel?.text = categories[indexPath.row].categoryName
        return cell!    }
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

