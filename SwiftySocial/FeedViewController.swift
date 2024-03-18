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
    var likeArray = [Int]()
    var documentIDArray = [String]()
    

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
        firestoreDatabase.collection("Post").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.mailArray.removeAll(keepingCapacity: false)
                self.descriptionArray.removeAll(keepingCapacity: false)
                self.imageUrlArray.removeAll(keepingCapacity: false)
                self.likeArray.removeAll(keepingCapacity: false)
                self.documentIDArray.removeAll(keepingCapacity: false)

                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        if let email = document.get("email") as? String {
                            self.mailArray.append(email)
                        }
                        if let like = document.get("likes") as? Int {
                            self.likeArray.append(like)
                        } else {
                            self.likeArray.append(0)
                        }
                        if let imageUrl = document.get("imageURL") as? String {
                            self.imageUrlArray.append(imageUrl)
                        }
                        if let description = document.get("description") as? String {
                            self.descriptionArray.append(description)
                             let docID = document.documentID
                                self.documentIDArray.append(docID)
                            
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
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.documentID = documentIDArray[indexPath.row]
        return cell }
    }
    
    

     
