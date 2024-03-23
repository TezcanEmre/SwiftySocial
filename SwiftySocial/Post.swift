//
//  Post.swift
//  SwiftySocial
//
//  Created by Perseus on 23.03.2024.
//

import Foundation
class Post {
    var mail : String
    var description : String
    var imgURL : String
    var like : String
    var docID : String
    init(mail: String, description: String, imgURL: String, like: String, docID: String) {
        self.mail = mail
        self.description = description
        self.imgURL = imgURL
        self.like = like
        self.docID = docID
    }
}
