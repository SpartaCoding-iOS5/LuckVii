//
//  ViewController.swift
//  LuckVii
//
//  Created by 김손겸 on 12/13/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let movieDetailView = MovieDetailView()
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        buttonActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    // 네비게이션 바 설정
    private func setNavigationBarStyle() {
        navigationController?.navigationBar.barTintColor = UIColor.black
        
        // 네비게이션 바 반투명
        navigationController?.navigationBar.isTranslucent = true
        // 네비게이션 바 하단 줄 없애기
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // 버튼 액션만 따로 정리
    private func buttonActions() {
        movieDetailView.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
    }
    
    // 버튼 클릭 애니메이션
    private func animateButtonPress(_ button: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            // 눌렸을 때 크기가 작아짐
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: { _ in
            // 애니메이션 완료 후 원래 크기로 돌아옴
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    // 좋아요 버튼 클릭 시 색 변경
    @objc private func likeButtonTapped(_ sender: UIButton) {
        animateButtonPress(sender)
        
        // 버튼 색상 변경
        if sender.titleColor(for: .normal) == .lightGray {
            sender.setTitleColor(.systemRed, for: .normal)
            sender.layer.borderColor = UIColor.red.cgColor
        } else {
            sender.setTitleColor(.lightGray, for: .normal)
            sender.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
