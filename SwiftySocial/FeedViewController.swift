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
   
    /*
    var mailArray = [String]()
    var descriptionArray = [String]()
    var imageUrlArray = [String]()
    var likeArray = [Int]()
    var documentIDArray = [String]()
    */
    var postArray = [Post]()

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
                self.postArray.removeAll(keepingCapacity: false)
               /* self.mailArray.removeAll(keepingCapacity: false)
                self.descriptionArray.removeAll(keepingCapacity: false)
                self.imageUrlArray.removeAll(keepingCapacity: false)
                self.likeArray.removeAll(keepingCapacity: false)
                self.documentIDArray.removeAll(keepingCapacity: false) */

                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        if let email = document.get("email") as? String {
                            if let like = document.get("likes") as? Int {
                                if let imageUrl = document.get("imageURL") as? String {
                                    if let description = document.get("description") as? String {
                                        let docID = document.documentID
                                        let post = Post(mail: email, description: description, imgURL: imageUrl, like: String(like), docID: docID)
                                        self.postArray.append(post)
                                    }
                                }
                            } else {
                                //self.likeArray.append(0)
                            }
                        }
                       
                    }
                }
                self.feedTableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailLabel.text = postArray[indexPath.row].mail
        cell.descriptionLabel.text = postArray[indexPath.row].description
        cell.feedImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].imgURL))
        cell.likeLabel.text = postArray[indexPath.row].like
        cell.documentID = postArray[indexPath.row].docID
        return cell }
    }
    
    

     
