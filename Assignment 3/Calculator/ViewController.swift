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
    @IBOutlet weak var outputLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func calcButtonPushed(_ sender: Any) {
        
        let beforeTax = Double(totalBeforeTaxText.text!)
        let tax = Double(taxText.text!)
        let discount = Double(discountPercText.text!)
        
        if(beforeTax == nil || tax == nil || discount == nil){
            outputLabel.text = "Error: Missing Input"
        }else{
            let taxAmount:Double = Double(beforeTax!) * Double(tax!)
        
            let beforeDiscount:Double = Double(taxAmount) + (beforeTax!)
        
            let discountAmount:Double = Double(beforeDiscount) * (discount!)
        
            let finalTotal = beforeDiscount - discountAmount
        
            var answerArray = DataController.answerList()
            let formatter = NumberFormatter()
            
            formatter.numberStyle = .currency
            
            if let formattedFinal = formatter.string(from:finalTotal as NSNumber){
                outputLabel.text = "\(formattedFinal)"
                answerArray.append(formattedFinal)
            }
            
            var outputString = ""
            
            answerArray = answerArray.reversed()
            
            for answer in answerArray{
                outputString.append(answer)
                outputString.append("\n")
            }
            
            outputLabel2.text = outputString
            
            DataController.logNewAnswer(newAnswer: String(finalTotal))
        }
    }
    
}

