//
//  ChatViewController.swift
//  Caravan
//
//  Created by Aubrey Spannagel on 12/15/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var newMessageTextField: UITextField!
    
    var eventName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = eventName
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        let userRef = db.collection("users").document(user!)
        
        userRef.getDocument { (snapshot, error) in
           
            let username = snapshot?.data()!["username"] as? String
        db.collection("users").document(user!).collection("events").document(self.eventName).collection("chat").addDocument(data: ["username": username!, "message": self.newMessageTextField.text!])
            
        db.collection("events").document(self.eventName).collection("chat").addDocument(data: ["username": username!, "message": self.newMessageTextField.text!])
        }
        
        newMessageTextField.text = ""
    }
}
