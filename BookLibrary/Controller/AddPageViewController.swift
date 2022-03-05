//
//  AddPageViewController.swift
//  BookLibrary
//
//  Created by Akın Aksoy on 5.03.2022.
//

import UIKit

class AddPageViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameInput: UITextField!
    @IBOutlet weak var AuthorInput: UITextField!
    @IBOutlet weak var PageInput: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
    }
    
   
}
