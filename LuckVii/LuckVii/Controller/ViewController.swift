//
//  ViewController.swift
//  LuckVii
//
//  Created by 손겸 on 12/16/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let searchVC = SearchViewController()
        addChild(searchVC)
        view.addSubview(searchVC.view)
        searchVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        searchVC.didMove(toParent: self)
    }


}
