//
//  SingUpVC.swift
//  FirebaseTodoList
//
//  Created by Israel Manzo on 12/2/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class SingUpVC: UITableViewController {
    
    @IBOutlet weak var userPhoto: UIImageView!
    
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var countryTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func signUpAction(_ sender: Any) {
    }
}
