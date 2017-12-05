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
    
    // MARK: - LOG IN FUNCTION
    @IBAction func logInAction(_ sender: Any) {
        
        guard let email = emailTxt.text, let password = passwordTxt.text else {return}
        
        networkingService.signIn(email: email, password: password)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
        present(vc, animated: true, completion: nil) 
    }
    
    @IBAction func unwindToLogin(storyboard: UIStoryboardSegue){}
}

