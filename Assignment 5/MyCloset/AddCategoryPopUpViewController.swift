//
//  AddCategoryPopUpViewController.swift
//  MyCloset
//
//  Created by Aubrey Spannagel on 10/25/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import CoreData

class AddCategoryPopUpViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var newCategoryName: UITextField!
    
    

    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        
        let getCellInfo = DatabaseController.persistentStoreContainer().viewContext
        
        let newCategory = ClothingCategories(context: getCellInfo)
        newCategory.categoryName = newCategoryName.text
        
        DatabaseController.saveContext()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
