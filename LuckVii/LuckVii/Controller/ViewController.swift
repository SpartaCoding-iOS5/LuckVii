//
//  ViewController.swift
//  LuckVii
//
//  Created by 김손겸 on 12/13/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // 포스터 이미지
    private let posterImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.backgroundColor = .lightGray
        return imageview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }


}

