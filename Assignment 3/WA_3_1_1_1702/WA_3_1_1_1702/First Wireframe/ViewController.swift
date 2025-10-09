//
//  ViewController.swift
//  WA_3_1_1_1702
//
//  Created by Sunny Yadav on 9/25/25.
//

import UIKit

class ViewController: UIViewController {

    //MARK: initializing the First Screen View...
    let firstScreen = FirstView()
    
    //MARK: add the view to this controller while the view is loading...
    override func loadView() {
        view = firstScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


