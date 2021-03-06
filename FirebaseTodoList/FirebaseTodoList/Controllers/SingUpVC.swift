//
//  SingUpVC.swift
//  FirebaseTodoList
//
//  Created by Israel Manzo on 12/2/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class SingUpVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var userPhoto: UIImageView!
    
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var countryTxt: UITextField!
    
    var countriesArray = [String]()
    var pickerView: UIPickerView!
    
    let networkingService = NetworkingServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries()
        
        userPhoto.layer.cornerRadius = 235/2
        
    }
    
    // sub.MARK: - Countries from LOCALE array
    private func countries(){
        for code in Locale.isoRegionCodes {
            let country = Locale.current.localizedString(forRegionCode: code)!
            print(code)
            let name = Locale(identifier: "en_EN").localizedString(forCollationIdentifier: country) ?? "\(country)"
            countriesArray.append(name)
            countriesArray.sort(by: { (name1, name2) -> Bool in
                name1 < name2
            })
        }
        pickerView = UIPickerView()
        
        countryTxt.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController(gesture:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func dismissController(gesture: UIGestureRecognizer){
        view.endEditing(true)
    }
    
    
    // MARK: - Picker view data source function
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countriesArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTxt.text = countriesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = NSAttributedString(string: countriesArray[row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        return title
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        let data = UIImageJPEGRepresentation(userPhoto.image!, 0.8)
        
        guard let email = emailTxt.text,
            let username = usernameTxt.text,
            let password = passwordTxt.text,
            let country = countryTxt.text else {return}
        
        guard let ImageData = data else {return}
        
        networkingService.signUp(email:email, username: username, password: password, country: country, data: ImageData)
    }
    
    @IBAction func actionPhoto(_ sender: Any) {
        pickPhoto()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userPhoto.image = image
        } else {
            print("Image was not selected")
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SingUpVC {
    private func pickPhoto(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alert = UIAlertController(title: "Add Photo", message: "Choose a photo", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let photoAlbum = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let savePhoto = UIAlertAction(title: "Save Photo", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(photoAlbum)
        alert.addAction(savePhoto)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
