//
//  NetworkingServices.swift
//  FirebaseTodoList
//
//  Created by Israel Manzo on 12/2/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct NetworkingServices {
    
    let databaseRef = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    
    // MARK: - Creating a function where the user info is storaged
    private func saveInfo(user: User!, username: String, password: String, country: String){
        
        // sub.MARK: - Array of Dictionary hold the user
        let userInfo = ["email":user.email!, "username":username, "country":country, "photoUrl": String(describing: user.photoURL!), "user":user.uid]
        
        // Sub.MARK: - Create a user reference
        let userRef = databaseRef.child("users").child(user.uid)
        
        // Sub.MARK: - Saving user on database
        userRef.setValue(userInfo)
    }
    
    func signIn(email: String, password: String){
        
    }
}
