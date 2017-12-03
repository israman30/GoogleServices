//
//  LogInVC.swift
//  FirebaseTodoList
//
//  Created by Israel Manzo on 12/1/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    let networkingService = NetworkingServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func logInAction(_ sender: Any) {
        networkingService.signIn(email: emailTxt.text!, password: passwordTxt.text!)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogIn")
        present(vc, animated: true, completion: nil) 
    }
    
    @IBAction func unwindToLogin(storyboard: UIStoryboardSegue){}
}

