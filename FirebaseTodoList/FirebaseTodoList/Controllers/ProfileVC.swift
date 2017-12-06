//
//  ProfileVC.swift
//  FirebaseTodoList
//
//  Created by Israel Manzo on 12/3/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileVC: UIViewController {
    
    @IBOutlet weak var photoProfile: UIImageView!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var country: UITextField!
    
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: Storage! {
        return Storage.storage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoProfile.layer.cornerRadius = 250 / 2
        photoProfile.layer.borderWidth = 2
        photoProfile.layer.borderColor = UIColor.black.cgColor
        
        if Auth.auth().currentUser == nil {
            
            // Sub.MARK: - If there is not user, go back to LogIn
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogIn")
            present(vc, animated: true, completion: nil)
            
        } else {
            
            // Sub.MARK: - If there is a user, get info from firebase
            databaseRef.child("users").observe(.value, with: { (snapshot) in
                DispatchQueue.main.async {
                    let user = UserRetrive(snapshot: snapshot)
                    self.username.text = user.username
                    self.email.text = user.email
                    self.country.text = user.country
                    let imageUrl = String(user.photoUrl)
                    
                    // Sub.MARK: Retriving image url from storage
                    self.storageRef.reference(forURL: imageUrl).getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
                        
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            if let data = data {
                                self.photoProfile.image = UIImage(data: data)
                            }
                        }
                    })
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - LOG OUT FUNCION
    @IBAction func logOutAction(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogIn")
                present(vc, animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
