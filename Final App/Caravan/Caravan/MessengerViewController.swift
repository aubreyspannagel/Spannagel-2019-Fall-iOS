//
//  MessengerViewController.swift
//  Caravan
//
//  Created by Aubrey Spannagel on 12/3/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MessengerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    
    @IBOutlet var messengerTableView: UITableView!
    
    var eventNames = [Event]()
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEvents()
        reloadTable()
    }
    
    func fetchEvents(){
        let user = Auth.auth().currentUser?.uid
        let userRef = db.collection("users").document(user!)
        
        userRef.collection("events").order(by: "eventName").addSnapshotListener({ (snapshot, error) in
            
            if error != nil{
                print("error getting documents")
                
            }else{
                self.eventNames.removeAll()
                for document in snapshot!.documents{
                    let event = Event()
                    let data = document.data()
                    let events = data["eventName"] as? String
                    event.eventName = events
                    self.eventNames.append(event)
                    self.reloadTable()
                }
            }
        })
    }
    
    func reloadTable(){
        self.messengerTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagesCell")
        cell?.textLabel?.text = eventNames[indexPath.row].eventName
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = eventNames[indexPath.row].eventName
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController{
            viewController.eventName = selectedEvent!
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

}
