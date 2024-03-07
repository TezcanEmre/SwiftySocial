//
//  ProfileViewController.swift
//  SwiftySocial
//
//  Created by Perseus on 7.03.2024.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        do { try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil) }
        catch { print("error") }
    }
    

}
