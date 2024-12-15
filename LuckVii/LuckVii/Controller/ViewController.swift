//
//  ViewController.swift
//  LuckVii
//
//  Created by 김손겸 on 12/13/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let moviewDetailView = MovieDetailView()
    
    
    override func loadView() {
        view = moviewDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
    }
    
}
