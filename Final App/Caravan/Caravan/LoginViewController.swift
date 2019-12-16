//
//  LoginViewController.swift
//  Caravan
//
//  Created by Aubrey Spannagel on 11/30/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        //check for errors in text field like in sign up
        let error = validateFields()
        
        let trimEmail = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(error != nil){
            self.showError(error!)
        }else{
            Auth.auth().signIn(withEmail: trimEmail!, password: trimPassword!) { (result, err) in
                
                if err != nil{
                    self.showError(err!.localizedDescription)
                }
                
            }
            self.transitionToProfile()
        }
    }
    
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
          let trimEmail = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().sendPasswordReset(withEmail: trimEmail!, completion: nil)
        
    }
    
    func validateFields() -> String?{
        if(emailTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            return "Make sure all fields are filled"
        }
        
        return nil
    }
    
    func showError(_ message : String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToProfile(){
        let TabBarViewController = storyboard?.instantiateViewController(withIdentifier: "TabBarController")
        view.window?.rootViewController = TabBarViewController
        view.window?.makeKeyAndVisible()
    }
}
