//
//  ViewController.swift
//  SwiftySocial
//
//  Created by Perseus on 3.03.2024.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ImageViewLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecog1 = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecog1) }
    
    @IBAction func passResetButtonClicked(_ sender: Any) {
            let email = mailTextField.text!
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error != nil {
                    self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please check internet connection and try again" ) }
                else { self.errorMessage(titleInput: "Success", messageInput: "Password reset mail send!")} } }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        if mailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: mailTextField.text! , password: passwordTextField.text!) { (authDataRes, error) in
                if error != nil {
                    self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please check internet connection and try again" ) }
                else { self.performSegue(withIdentifier: "toFeedVC", sender: nil) } } }
        else { self.errorMessage(titleInput: "Error!", messageInput: "Please check e-mail and password") } }
    
    @objc func hideKeyboard() { view.endEditing(true) }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterVC", sender: nil) }
        
    func errorMessage (titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true, completion: nil) }
    
}

