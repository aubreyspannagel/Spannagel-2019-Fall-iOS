//
//  ChangeEmailViewController.swift
//  Caravan
//
//  Created by Aubrey Spannagel on 12/3/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import Firebase

class ChangeEmailViewController: UIViewController {
    
    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var verifyNewEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let user = Auth.auth().currentUser;
        user?.updateEmail(to: verifyNewEmailTextField.text!, completion: { (error) in
        })
        
        let alertController = (UIAlertController(title: "Email updated.", message: "Your email has successfully been changed.", preferredStyle: .alert))
        alertController.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        newEmailTextField.text = ""
        verifyNewEmailTextField.text = ""
    }
}

