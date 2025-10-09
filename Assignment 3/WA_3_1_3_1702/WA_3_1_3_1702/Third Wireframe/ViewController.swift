//
//  ViewController.swift
//  WA_3_1_3_1702
//
//  Created by Sunny Yadav on 9/26/25.
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

