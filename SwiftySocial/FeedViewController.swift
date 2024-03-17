//
//  FeedViewController.swift
//  SwiftySocial
//
//  Created by Perseus on 7.03.2024.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var mailArray = [String]()
    var descriptionArray = [String]()
    var imageUrlArray = [String]()
    

    @IBOutlet weak var feedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.delegate = self
        feedTableView.dataSource = self
        getFeedData()
    }
    override func viewWillAppear(_ animated: Bool) {
        feedTableView.reloadData()
    }
    func getFeedData() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post").addSnapshotListener { snapshot, error in
            if error != nil { print(error!.localizedDescription) }
                else {
                    self.mailArray.removeAll()
                                self.descriptionArray.removeAll()
                                self.imageUrlArray.removeAll()

                    if snapshot?.isEmpty != true && snapshot != nil {
                        for document in snapshot!.documents {
                            if let email = document.get("email") as? String {
                                self.mailArray.append(email)
                            }
                            if let imageUrl = document.get("imageURL") as? String { self.imageUrlArray.append(imageUrl) }
                            if let description = document.get("description") as? String {
                                self.descriptionArray.append(description)
                            }
                        }
                    
                    }
                    self.feedTableView.reloadData()
                }
            }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailArray.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailLabel.text = mailArray[indexPath.row]
        cell.descriptionLabel.text = descriptionArray[indexPath.row]
        cell.feedImageView.sd_setImage(with: URL(string: self.imageUrlArray[indexPath.row]))
        print(imageUrlArray)
        return cell }
    }
    
    

     
