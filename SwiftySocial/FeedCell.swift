//
//  FeedCell.swift
//  SwiftySocial
//
//  Created by Perseus on 17.03.2024.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
