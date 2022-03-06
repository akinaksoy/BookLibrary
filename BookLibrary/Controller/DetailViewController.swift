//
//  DetailViewController.swift
//  BookLibrary
//
//  Created by Akın Aksoy on 5.03.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    
    
    var choosenID : UUID?
    let bookData = BookData()
    override func viewDidLoad() {
        super.viewDidLoad()
        let book = bookData.getBookWithId(id: choosenID!)
        bookNameLabel.text = book?.name
        bookImageView.image = book?.getImage(bookData: (book?.image!)!)
        authorNameLabel.text = book?.author
        if let pageNumber = book?.pageNumber{
            pageNumberLabel.text = String(pageNumber)
        }
        
        
        // Do any additional setup after loading the view.
    }
    

   

}
