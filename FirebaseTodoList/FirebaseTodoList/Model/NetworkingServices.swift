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
    
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        return Storage.storage().reference()
    }
    
    
    // MARK: - # 3 -> Saving a function where the user info is storaged
    private func saveInfo(user: User!, username: String, password: String, country: String){
        
        // sub.MARK: - Array of Dictionary hold the user
        let userInfo = ["email":user.email!, "username":username, "country":country, "photoUrl": String(describing: user.photoURL!), "user":user.uid]
        
        // Sub.MARK: - Create a user reference
        let userRef = databaseRef.child("users").child(user.uid)
        
        // Sub.MARK: - Saving user on database
        userRef.setValue(userInfo)
        
        // Sub.MARK: - Sign in the user
        signIn(email: user.email!, password: password)
    }
    
    
    // MARK: - # 4 -> Sign in the user with info - this function is called on saveInfo()
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                if let user = user {
                    print(user.displayName!, "User sign in!!")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    // MARK: # 2 -> User is been set
    private func setUser(user: User!, username: String, password: String, country: String, data: Data!){
        // Sub.MARK: - Set path for user image
        let imagePath = "userImage\(user.uid)/userpic.jpg"
        
        // Sub.MARK: - Image reference
        let imageRef = storageRef.child(imagePath)
        
        // Sub.MARK: - Create Metadata for image
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        // Sub.MARK: - Save user image into Firebase storage file
        imageRef.putData(data, metadata: metaData) { (metaData, error) in
            if error == nil {
              let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        self.saveInfo(user: user, username: username, password: password, country: country)
                    } else {
                        print(error!.localizedDescription)
                    }
                })
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    // MARK: - # 1 -> create a user
    func signUp(email: String ,username: String, password: String, country: String, data: Data!){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                self.setUser(user: user, username: username, password: password, country: country, data: data)
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func resetPassword(email:String){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}

















