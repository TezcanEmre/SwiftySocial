//
//  FeedCell.swift
//  SwiftySocial
//
//  Created by Perseus on 17.03.2024.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    var documentID : String?
    
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        
        if likeButton.currentImage == UIImage(systemName: "hand.thumbsup") {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            if let likeCount = Int (likeLabel.text!) {
                let likeStore = ["likes" : likeCount + 1 ] as [String : Any]
                firestoreDatabase.collection("Post").document(documentID!).setData(likeStore,merge: true)
            }
            firestoreDatabase.collection("Post").document(documentID!)
        }
        else {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            if let likeCount = Int (likeLabel.text!) {
                let likeStore = ["likes" : likeCount - 1 ] as [String : Any]
                firestoreDatabase.collection("Post").document(documentID!).setData(likeStore,merge: true)
            }
            firestoreDatabase.collection("Post").document(documentID!)
            
        }
        
    }
    
    @IBAction func commentButtonClicked(_ sender: Any) {
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        likeButton.setImage(UIImage(systemName:"hand.thumbsup"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
