//
//  ViewController.swift
//  LuckVii
//
//  Created by Jamong on 12/13/24.
//

import UIKit

class ViewController: UIViewController {
    
    let searchView: SearchView = .init()
    
    override func loadView() {
        self.view = searchView
    }

    override func viewDidLoad() {
        view.backgroundColor = .black
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

