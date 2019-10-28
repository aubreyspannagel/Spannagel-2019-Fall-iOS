//
//  AddItemPopUpViewController.swift
//  MyCloset
//
//  Created by Aubrey Spannagel on 10/28/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import CoreData

class AddItemPopUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var brandTextField: UITextField!
    
    @IBOutlet weak var sizeTextField: UITextField!
    
    @IBOutlet weak var colorTextField: UITextField!
    
    @IBOutlet weak var conditionTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let getCellInfo = DatabaseController.persistentStoreContainer().viewContext
        
        let newItem = ClothingItems(context: getCellInfo)

        newItem.itemBrand = brandTextField.text
        newItem.itemSize = sizeTextField.text
        newItem.itemColorPattern = colorTextField.text
        newItem.itemCondition = conditionTextField.text
        
        DatabaseController.saveContext()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
