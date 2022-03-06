//
//  ViewController.swift
//  BookLibrary
//
//  Created by Akın Aksoy on 5.03.2022.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    var chosenID : UUID?
    var bookData = BookData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getData()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,target: self, action: #selector(addButtonClicked))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    @objc func addButtonClicked() {
        performSegue(withIdentifier: "toAddBookPage", sender: nil)
    }
    
    @objc func getData(){
        // Remove all data for duplicate datas
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let bookList = bookData.getBooks()
        if bookList.count > 0 {
            for book in bookList {
                nameArray.append(book.name!)
                idArray.append(book.id!)
                
        }
            self.tableView.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let idString = idArray[indexPath.row]
            var isDeleted = bookData.deleteBook(id: idString)
            if isDeleted == true {
                nameArray.remove(at: indexPath.row)
                idArray.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenID = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailPage", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailPage" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.choosenID = chosenID
        }
    }
    
    
}

