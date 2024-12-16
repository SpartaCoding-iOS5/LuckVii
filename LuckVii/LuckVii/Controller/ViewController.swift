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
        // 자식 컨트롤러로 추가
        let searchVC = SearchViewController()
        addChild(searchVC)
        view.addSubview(searchVC.view)
        
        // 레이아웃 설정
        searchVC.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        //자식 컨트롤러에 알림
        searchVC.didMove(toParent: self)
    }


}
