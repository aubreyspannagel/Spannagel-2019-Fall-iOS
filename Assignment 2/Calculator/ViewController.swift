//
//  ViewController.swift
//  Calculator
//
//  Created by Aubrey Spannagel on 9/8/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var calcLabel: UILabel!
    @IBOutlet weak var totalBeforeTaxLabel: UILabel!
    @IBOutlet weak var taxPercLabel: UILabel!
    @IBOutlet weak var discountPercLabel: UILabel!
    @IBOutlet weak var totalBeforeTaxText: UITextField!
    @IBOutlet weak var taxText: UITextField!
    @IBOutlet weak var discountPercText: UITextField!
     @IBOutlet weak var calcButton: UIButton!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func calcButtonPushed(_ sender: Any) {
        
        let beforeTax = Double(totalBeforeTaxText.text!)
        let tax = Double(taxText.text!)
        let discount = Double(discountPercText.text!)
        
        let taxAmount:Double = Double(beforeTax!) * Double(tax!)
        
        let beforeDiscount:Double = Double(taxAmount) + (beforeTax!)
        
        let discountAmount:Double = Double(beforeDiscount) * (discount!)
        
        let finalTotal = beforeDiscount - discountAmount
        
        outputLabel.text = "$ \(finalTotal)"
    }
    
}

