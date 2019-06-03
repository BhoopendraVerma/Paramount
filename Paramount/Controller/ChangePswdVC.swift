//
//  ChangePswdVC.swift
//  Paramount
//
//  Created by Yugasalabs-28 on 27/05/2019.
//  Copyright © 2019 Yugasalabs. All rights reserved.
//

import UIKit

class ChangePswdVC: UIViewController,UITextFieldDelegate {

    @IBOutlet var oldPswdTF: UITextField!
    @IBOutlet var newPswdTF: UITextField!
    @IBOutlet var cnfrmPswdTF: UITextField!
    @IBOutlet var submitBTN: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 

    @IBAction func submitBtn(_ sender: UIButton) {
        guard let oldPswd = oldPswdTF.text, oldPswd != "" else {
            self.showAlertMessage(titleStr: "Paramount", messageStr: "Please enter your oldPassword.")
            return
        }
        guard let newPswd = newPswdTF.text, newPswd != "" else {
            self.showAlertMessage(titleStr: "Paramount", messageStr: "Please enter your new password.")
            return
        }
        guard let cnfrmPswd = cnfrmPswdTF.text, cnfrmPswd != "" else {
            self.showAlertMessage(titleStr: "Paramount", messageStr: "Please enter your confirm password.")
            return
        }
        self .registerButtonTapped()
        
    }
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerButtonTapped() {
        
        guard let password = newPswdTF.text, !password.isEmpty,
            let confirm = cnfrmPswdTF.text, !confirm.isEmpty else {
                self.showAlertMessage(titleStr: "Paramount", messageStr: "Password Field is empty")
                return
        }
        guard password == confirm else {
            self.showAlertMessage(titleStr: "Paramount", messageStr: "Passwords Do Not Match")
            return
        }
       print("Registered")
    }
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textstring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let length = textstring.count
        if length > 4 {
            textField .resignFirstResponder()
            return false
        }
        return true
    }
}
