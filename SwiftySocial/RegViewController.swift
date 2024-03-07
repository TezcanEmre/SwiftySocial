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

        // Do any additional setup after loading the view.
    }
    @IBAction func regButtonClicked(_ sender: Any) {
        if regMailTextField.text != "" && regPasswordTextField.text != "" {
            Auth.auth().createUser(withEmail: regMailTextField.text!, password: regPasswordTextField.text!) { authDataRes, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please check internet connection and try again" ) }
                else { self.toLoginVC() } } }
        
        else {
            errorMessage(titleInput: "Error!", messageInput: "Please fill all lines!") } }
    
    @IBAction func loginButtonClicked(_ sender: Any) { toLoginVC() }
    func errorMessage (titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true, completion: nil) }
    func toLoginVC() { dismiss(animated: true, completion: nil) }

    

}
