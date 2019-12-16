//
//  SignUpViewController.swift
//  Caravan
//
//  Created by Aubrey Spannagel on 11/30/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var verifyEmailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        let error = validateFields()
        
        let trimEmail = emailTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines)
        let trimPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimUsername = usernameTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines)
        
        if(error != nil){
            showError(error!)
            
        }else{
            Auth.auth().createUser(withEmail: trimEmail!, password: trimPassword!) { (result, err) in
            
                
                //check for errors
                if err != nil {
                    self.showError(err!.localizedDescription)
                }else{
                    //store username
                    self.db.collection("users").document(result!.user.uid).setData(["uid":result!.user.uid, "username": trimUsername!, "password": trimPassword!,"email": trimEmail!]){ (error) in
                        
                        if error != nil {
                            self.showError("Error saving data")
                        }
                    }
                    self.transitionToProfile()
                }
            }
        }
    }
    
    func validateFields() -> String?{
        
        let trimEmail = emailTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines)
        let trimPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimVerifyEmail = verifyEmailTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines)
        let trimUsername = usernameTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines)
        //let db = Firestore.firestore()
        
        //fields are blank
        if( trimUsername == "" || trimEmail == "" || trimVerifyEmail == "" || trimPassword == ""){
            return "Make sure all fields are filled"
        }
        
        //invalid password
        if(isPasswordValid(trimPassword!) == false){
            return "Password must contain at least 8 characters and contain a number and special character"
        }
        
        //invalid email
        if(isEmailValid(trimEmail!) == false){
            return "Please enter a valid email"
        }
        
        //username taken
        if(isUsernameTaken(trimUsername!) == true){
            return "Username is taken"
        }
        
        //emails do not match
        if(trimEmail != trimVerifyEmail){
            return "Emails do not match"
        }
        
        return nil
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES%@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    //check if username is taken
    func isUsernameTaken(_ username : String) -> Bool {
        let trimUsername = usernameTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines)
        var r = false;
        let userRef = self.db.collection("users").document(trimUsername!)
        userRef.getDocument { (document, err) in
            if let document = document , document.exists{
                r = true
            }
        }
        return r
    }
    
    //check if email is valid
    func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}” +“~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-” +“9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func showError(_ message : String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToProfile(){
        let profileViewController = storyboard?.instantiateViewController(withIdentifier: "TabBarController")
        view.window?.rootViewController = profileViewController
        view.window?.makeKeyAndVisible()
    }
}
