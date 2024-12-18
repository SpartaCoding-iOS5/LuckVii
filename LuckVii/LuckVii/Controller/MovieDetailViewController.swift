//
//  ViewController.swift
//  LuckVii
//
//  Created by 김손겸 on 12/13/24.
//

import UIKit
import SafariServices

class MovieDetailViewController: UIViewController {
    let movieDetailView = MovieDetailView()
    private var movie: Movie?
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
        movieDetailView.bookingButton.addTarget(self, action: #selector(bookingButtonTapped), for: .touchUpInside)
        movieDetailView.trailerButton.addTarget(self, action: #selector(playTrailer), for: .touchUpInside)
        movieDetailView.shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
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
    
    // 좋아요 버튼에 표시될 텍스트 업데이트
    private func updateLikeButtonTitle() {
        let updatedTitle = "♥ \(likeCount.formatted())" // 형식화된 숫자
        movieDetailView.likeButton.setTitle(updatedTitle, for: .normal)
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
    
    // 공유 버튼
    @objc private func shareButtonTapped() {
        let appURL = "https://github.com/SpartaCoding-iOS5/LuckVii"
        
        // 클립보드에 URL 복사
        UIPasteboard.general.string = appURL
        
        // 알림을 사용자에게 보여줌
        let alert = UIAlertController(title: "URL 복사 완료!", message: "앱 링크가 복사되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    
    // 예고편 재생
    @objc private func playTrailer() {
        Task {
            do {
                // 1. 네트워크 요청으로 예고편 데이터 가져오기
                let videoData: VideoData = try await NetworkManager.shared.fetchData(
                    endpoint: .video(id: 1234),
                    parameters: NetworkManager.URLParameterSet.common
                )
                
                // 2. YouTube 링크 가져오기
                guard let video = videoData.results.first(where: { $0.site.lowercased() == "youtube" }),
                      let url = video.getVideoURL() else {
                    showAlert(message: "예고편 URL을 가져올 수 없습니다.")
                    return
                }
                
                // 3. Safari로 예고편 재생
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true)
                
            } catch {
                // 오류 처리
                showAlert(message: "예고편을 로드하는 데 실패했습니다: \(error.localizedDescription)")
            }
        }
    }
    // 예고편 예외 상황 알림창
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}


extension MovieDetailViewController {
    
    func setDetailViewData(_ dataSource: MovieDataSource) {
        movieDetailView.setDetailView(dataSource)
    }
}
