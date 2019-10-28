//
//  ArticleListViewController.swift
//  MyCloset
//
//  Created by Aubrey Spannagel on 10/27/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//
import UIKit
import CoreData

class ArticleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items:[ClothingItems] = []
    let context = DatabaseController.persistentStoreContainer().viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var itemLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest:NSFetchRequest = ClothingItems.fetchRequest()
        
        do{
            items = try context.fetch(fetchRequest)
        }
        catch{
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleItemCell")
        cell?.textLabel?.text = items[indexPath.row].itemBrand
        return cell!}
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}






