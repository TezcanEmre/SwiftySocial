//
//  UploadViewController.swift
//  SwiftySocial
//
//  Created by Perseus on 7.03.2024.
//

import UIKit
import Firebase
import FirebaseStorage
class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.isEnabled = false
        let gestureRecog1 = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        uploadImageView.isUserInteractionEnabled = true
        let gestureRecog2 = UITapGestureRecognizer(target: self, action: #selector(takeImage))
        view.addGestureRecognizer(gestureRecog1)
        uploadImageView.addGestureRecognizer(gestureRecog2) }
    
    @objc func hideKeyboard() { view.endEditing(true) }
    @objc func takeImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil) }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.editedImage] as? UIImage
        shareButton.isEnabled = true
        self.dismiss(animated: true, completion: nil) }
    
    @IBAction func shareButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("userMedia")
        if let imgData = uploadImageView.image?.jpegData(compressionQuality: 0.6) {
            let photoUUID = UUID().uuidString
            let imgRef = mediaFolder.child("\(photoUUID).jpg")
            imgRef.putData(imgData, metadata: nil) { (strMetaData, error) in
                if error != nil {
                    self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please try again" ) }
                else {
                    imgRef.downloadURL { url, error in
                        if error == nil {
                            let imgUrl = url?.absoluteString
                            if let imgUrl = imgUrl {
                                let firestoreDatabase = Firestore.firestore()
                                let firestorePost = [ "imageURL": imgUrl, "comment": self.descriptionTextField.text!, "email": Auth.auth().currentUser!.email!, "date": FieldValue.serverTimestamp()  ] as [String : Any]
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { error in
                                    if error != nil { self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Please try again.") }
                                    else { self.descriptionTextField.text = ""
                                        self.uploadImageView.image = UIImage(named: "uploadIcon")
                                        self.tabBarController?.selectedIndex = 0 } } } } } }
            }
        }
    }
    func errorMessage (titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true, completion: nil) }
    



}



