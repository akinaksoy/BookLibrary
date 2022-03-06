//
//  AddPageViewController.swift
//  BookLibrary
//
//  Created by Akın Aksoy on 5.03.2022.
//

import UIKit

class AddPageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameInput: UITextField!
    @IBOutlet weak var AuthorInput: UITextField!
    @IBOutlet weak var PageInput: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    
    var bookName : String?
    var authorName : String?
    var pageNumber : Int?
    
    let bookData = BookData()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let recognizerGesture = UITapGestureRecognizer.init(target: self, action: #selector(selectImage))
        
        bookImageView.addGestureRecognizer(recognizerGesture)
        bookImageView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if bookNameInput.text != "" {
           bookName = bookNameInput.text
        }
        if(AuthorInput.text != ""){
             authorName = AuthorInput.text
        }
        if(PageInput.text != ""){
            pageNumber = Int(PageInput.text!)
        }
        let imageData = bookImageView.image?.jpegData(compressionQuality: 0.5)
        
        let book = Book(bookName: bookName!, bookAuthor: authorName!, bookID: UUID(), bookImage: imageData!, bookPageNumber: pageNumber!)
        bookData.addToDatabase(book: book)
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        bookImageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        SaveButton.isEnabled = true
        
    }
    
    
   
}
