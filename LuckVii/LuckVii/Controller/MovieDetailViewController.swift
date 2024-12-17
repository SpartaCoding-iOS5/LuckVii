//
//  ViewController.swift
//  LuckVii
//
//  Created by 김손겸 on 12/13/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let movieDetailView = MovieDetailView()
    private var likeCount: Int = 0
    private var isLiked: Bool = false
    
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
        setupLikeCount()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    // 네비게이션 바 설정
    private func setNavigationBarStyle() {
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // 서버 없어서 좋아요 랜덤으로 가져옴
    private func setupLikeCount() {
        likeCount = Int.random(in: 1001...3001)
        updateLikeButtonTitle()

    }
    
    // 버튼 액션만 따로 정리
    private func buttonActions() {
        movieDetailView.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        movieDetailView.bookingButton.addTarget(self, action: #selector(bookingButtonTapped), for: .touchUpInside) // 예매하기 버튼에 액션 추가
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
    // 예매하기 클릭 시 날짜/시간 선택 화면으로 이동
    @objc func bookingButtonTapped() {
        let selectDateVC = SelectDateViewController()
        navigationController?.pushViewController(selectDateVC, animated: true)
    }
    
    // 좋아요 버튼 클릭 시 색 변경
    @objc private func likeButtonTapped(_ sender: UIButton) {
        animateButtonPress(sender)
        
        if isLiked {
            // 이미 좋아요가 눌려있다면 취소하고 카운트 감소
            likeCount -= 1
        } else {
            // 좋아요가 눌려있지 않으면 카운트 증가
            likeCount += 1
        }
        
        // 좋아요 상태 반전시키는 토글
        isLiked.toggle()
        
        updateLikeButtonTitle()
        
        // 버튼 색상 변경
        if isLiked {
            sender.setTitleColor(.systemRed, for: .normal)
            sender.layer.borderColor = UIColor.red.cgColor
        } else {
            sender.setTitleColor(.lightGray, for: .normal)
            sender.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    // 좋아요 버튼에 표시될 텍스트 업데이트
    private func updateLikeButtonTitle() {
        let updatedTitle = "♥ \(likeCount.formatted())" // 형식화된 숫자
        movieDetailView.likeButton.setTitle(updatedTitle, for: .normal)
    }
}

extension MovieDetailViewController {
    
    func setDetailViewData(_ dataSource: MovieDataSource) {
        movieDetailView.setDetailView(dataSource)
    }
}
