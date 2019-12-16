//
//  ProfileViewController.swift
//  Caravan
//
//  Created by Aubrey Spannagel on 12/1/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var usernameDisplay: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePickerController:UIImagePickerController? = nil
    let db = Firestore.firestore()
    let storage = Storage.storage()
    let user = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        imagePickerController?.allowsEditing = true
        
        let docRef = db.collection("users").document(user!)
        docRef.getDocument { (snapshot, error) in
            if let document = snapshot, snapshot!.exists{
                let username = document.get("username")
                self.usernameDisplay.text = username as? String
            }else{
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func addProfilePhoto(_ sender: Any) {
        
        let alertController = UIAlertController(nibName: "Choose Photo Source", bundle: nil)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(alertAction) in self.imagePickerController?.sourceType = .photoLibrary
            self.present(self.imagePickerController!, animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title:"Camera Library", style: .default, handler: { (alertAction) in
            
            if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                self.imagePickerController?.sourceType = .camera
            }else{
                self.imagePickerController?.sourceType = .savedPhotosAlbum
            }
            self.present(self.imagePickerController!, animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imagePickerController!.dismiss(animated: true, completion: nil)
        imageView.image = info[.editedImage] as? UIImage
        self.saveToDatabase(imageView.image!)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePickerController!.dismiss(animated: true, completion: nil)
    }
    
    func saveToDatabase(_ image: UIImage){
        let storageRef = storage.reference()
        let data = image.pngData()!
        let imageName = NSUUID().uuidString
        let profilePhotoRef = storageRef.child("profilePhotos/"+(imageName))
        
        profilePhotoRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            profilePhotoRef.downloadURL { (url, error) in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    let docRef = self.db.collection("users").document(self.user!)
                    docRef.setData(["profilePhoto" : url!], merge: true)
                }
            }
        }
    }
}


