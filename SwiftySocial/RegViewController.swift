//
//  RegViewController.swift
//  SwiftySocial
//
//  Created by Perseus on 3.03.2024.
//

import UIKit
import Firebase

class RegViewController: UIViewController {
    @IBOutlet weak var regMailTextField: UITextField!
    @IBOutlet weak var regPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecog1 = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecog1)

    }
    @objc func hideKeyboard() { view.endEditing(true) }
    @IBAction func regButtonClicked(_ sender: Any) {
        if regMailTextField.text != "" && regPasswordTextField.text != "" {
            Auth.auth().createUser(withEmail: regMailTextField.text!, password: regPasswordTextField.text!) { authDataRes, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please check internet connection and try again" ) }
                else {
                    self.errorMessage(titleInput: "Congrats!", messageInput: "Account created succesfully!")
                    self.toLoginVC() } } }
        
        else { errorMessage(titleInput: "Error!", messageInput: "Please fill all lines!") } }
    
    @IBAction func loginButtonClicked(_ sender: Any) { toLoginVC() }
    func errorMessage (titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true, completion: nil) }
    func toLoginVC() { dismiss(animated: true, completion: nil) }

    

}
