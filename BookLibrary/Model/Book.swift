//
//  Book.swift
//  BookLibrary
//
//  Created by Akın Aksoy on 5.03.2022.
//

import Foundation
import UIKit

class Book {
    
    var name : String?
    var author : String?
    var id : UUID?
    var image : Data?
    var pageNumber : Int = 0
    
    
    
    init(bookName : String,bookAuthor : String,bookID : UUID, bookImage : Data , bookPageNumber : Int){
        name = bookName
        author = bookAuthor
        id = bookID
        image = bookImage
        pageNumber = bookPageNumber
        
    }
    
    func getImage(bookData : Data) -> UIImage{
        let image = UIImage(data: bookData)
        return image!
    }
    
}
