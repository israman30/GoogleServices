//
//  User.swift
//  FirebaseTodoList
//
//  Created by Israel Manzo on 12/5/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct UserRetrive {
    var username: String!
    var email: String!
    var photoUrl: String!
    var country: String!
    var ref: DatabaseReference?
    var key: String!
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapShotValue = snapshot.value as! [String:Any]
        username = snapShotValue["username"] as! String
        email = snapShotValue["email"] as! String
        photoUrl = snapShotValue["photoUrl"] as! String
        country = snapShotValue["country"] as! String
        ref = snapshot.ref
    }
    
}

