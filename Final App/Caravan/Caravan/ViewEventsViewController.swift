//
//  ViewEventsViewController.swift
//  Caravan
//
//  Created by Aubrey Spannagel on 12/5/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ViewEventsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource
{
    
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    var events = [Event]()
    
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
                self.events.removeAll()
                for document in snapshot!.documents{
                    let event = Event()
                    let data = document.data()
                    let eventName = data["eventName"] as? String
                    event.eventName = eventName
                    self.events.append(event)
                    self.reloadTable()
                }
            }
        })
    }
    
    func reloadTable() -> Void{
        self.eventsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    //prints number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    //whats in each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell")
        cell?.textLabel?.text = events[indexPath.row].eventName
        return cell!
    }
}
