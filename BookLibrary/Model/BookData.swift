//
//  BookData.swift
//  BookLibrary
//
//  Created by Akın Aksoy on 5.03.2022.
//

import Foundation
import UIKit
import CoreData

class BookData{
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        return context
    }
    func getFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        fetchRequest.returnsObjectsAsFaults = false
        return fetchRequest
    }
    
    func GetDatasFromDatabase(context : NSManagedObjectContext , fetchRequest : NSFetchRequest<NSFetchRequestResult>) -> [NSFetchRequestResult]?{
        
        do{
            let results = try context.fetch(fetchRequest)
            return results
        }catch{
            print(error)
            return nil
        }
        
    }
    
    func prepareBookList(results : [NSFetchRequestResult]) -> [Book]{
        var bookList = [Book]()
        if results.count > 0 {
            for result in results as! [NSManagedObject] {
                let bookName = result.value(forKey: "name") as? String
                let bookAuthor = result.value(forKey: "author") as? String
                let bookPage = result.value(forKey: "pageNumber") as? Int
                let id = result.value(forKey: "id") as? UUID
                let image = result.value(forKey: "image") as? Data
                
                let book = Book(bookName: bookName!, bookAuthor: bookAuthor!, bookID: id!, bookImage: image!, bookPageNumber: bookPage!)
                bookList.append(book)
            }
        }
        return bookList
        
       
        
    }
    
    func getBookWithId(id : UUID) -> Book? {
        let uuidString = id.uuidString
        let fetchRequest = getFetchRequest()
        let context = getContext()
        fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
        fetchRequest.returnsObjectsAsFaults = false
        var name : String?
        var image : Data?
        var author : String?
        var pageNumber : Int?
        var id : UUID?
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let bookName = result.value(forKey: "name") as? String {
                      name = bookName
                    }
                    if let bookid = result.value(forKey: "id") as? UUID {
                        id = bookid
                    }
                    if let bookAuthor = result.value(forKey: "author") as? String {
                        author = bookAuthor
                    }
                    if let number = result.value(forKey: "pageNumber") as? Int {
                        pageNumber = number
                    }
                    if let imageData = result.value(forKey: "image") as? Data {
                        image = imageData
                    }
                    
                }
                let book = Book(bookName: name!, bookAuthor: author!, bookID: id!, bookImage: image!, bookPageNumber: pageNumber!)
                return book
            }
        }catch{
            print(error)
            return nil
        }
        return nil
        
    }
    
    
    func getBooks() -> [Book]{
        
        let fetchRequest = getFetchRequest()
        let context = getContext()
        
        let datas = GetDatasFromDatabase(context: context, fetchRequest: fetchRequest)
        let BookList : [Book] = prepareBookList(results: datas!)
        
        return BookList
    }
    func addToDatabase(book : Book) {
        
        let context = getContext()
        let newBook = NSEntityDescription.insertNewObject(forEntityName: "Books", into: context)
        
        newBook.setValue(book.name, forKey: "name")
        newBook.setValue(book.id, forKey: "id")
        newBook.setValue(book.image, forKey: "image")
        newBook.setValue(book.pageNumber, forKey: "pageNumber")
        newBook.setValue(book.author, forKey: "author")
        
        do {
            try context.save()
        }catch{
            print(error)
        }
        
        
        
    }
    
    
    
}
