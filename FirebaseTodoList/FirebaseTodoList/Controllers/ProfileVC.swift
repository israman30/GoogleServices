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
    
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        return Storage.storage().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            
            // Sub.MARK: - If there is not user, go back to LogIn
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogIn")
            present(vc, animated: true, completion: nil)
            
        } else {
            
            // Sub.MARK: - If there is a user, get info from firebase
            databaseRef.child("users").observe(.value, with: { (snapshot) in
                DispatchQueue.main.async {
                    let user = UserRetrive(snapshot: snapshot)
                    
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
