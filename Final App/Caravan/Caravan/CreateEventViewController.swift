//
//  CreateEventViewController.swift
//  Caravan
//
//  Created by Aubrey Spannagel on 12/5/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import Firebase

class CreateEventViewController: UIViewController {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    
    @IBOutlet weak var beginDateTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    // Create a reference to the cities collection
    //    let citiesRef = db.collection("cities")
    //
    //    // Create a query against the collection.
    //    let query = citiesRef.whereField("state", isEqualTo: "CA")
    
    @IBAction func joinButtonPressed(_ sender: Any) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        
        let userRef = db.collection("users").document(user!)
        let eventRef = db.collection("events")
        
        userRef.getDocument { (snapshot, error) in
            if let document = snapshot, snapshot!.exists{
                let username = document.get("username")
                db.collection("events").document(self.eventNameTextField.text!).collection("users").addDocument(data: ["username": username!])
            }
        }
        
        eventRef.whereField("eventName", isEqualTo: eventNameTextField.text!).getDocuments { (snapshot, error) in
            for document in snapshot!.documents{
                let data = document.data()
                userRef.collection("events").addDocument(data: data)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createEventButtonTapped(_ sender: Any) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser?.uid
        let userRef = db.collection("users").document(user!)
        userRef.getDocument { (snapshot, error) in
            
            if let document = snapshot, snapshot!.exists{
                let username = document.get("username")
                db.collection("events").document(self.eventNameTextField.text!).collection("users").addDocument(data: ["username": username!])
            }
        }
        db.collection("events").document(eventNameTextField.text!).setData(["eventName" : eventNameTextField.text!, "beginDate": beginDateTextField.text!, "endDate": endDateTextField.text!, "location": locationTextField.text!]) { (error) in
            if error != nil{
                print("error creating document")
            }
        }
        db.collection("users").document(user!).collection("events").document(eventNameTextField.text!).setData(["eventName" : eventNameTextField.text!, "beginDate": beginDateTextField.text!, "endDate": endDateTextField.text!, "location": locationTextField.text!])
        self.navigationController?.popViewController(animated: true)
    }
}
