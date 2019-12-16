//
//  ChangePasswordViewController.swift
//  Caravan
//
//  Created by Aubrey Spannagel on 12/3/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import Firebase

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPasswordTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var verifyNewPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let user = Auth.auth().currentUser;
        user?.updatePassword(to: verifyNewPasswordTextField.text!, completion: { (error) in
        })
        let alertController = (UIAlertController(title: " Password updated.", message: "Your password has successfully been changed.", preferredStyle: .alert))
        alertController.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        newPasswordTextField.text = ""
        verifyNewPasswordTextField.text = ""
        oldPasswordTextField.text = ""
    }
}
