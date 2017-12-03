//
//  ResetPasswordVC.swift
//  FirebaseTodoList
//
//  Created by Israel Manzo on 12/2/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPassword: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    
    let networkService = NetworkingServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetAction(_ sender: Any) {
        
        guard let email = emailTxt.text else {return}
        
        networkService.resetPassword(email: email)
    }
}
