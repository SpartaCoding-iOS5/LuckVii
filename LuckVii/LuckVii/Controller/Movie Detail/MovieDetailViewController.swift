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
    private var movieData: MovieDataSource?
    private var movie: Movie?
    private var likeCount: Int = 0
    private var isLiked: Bool = false
    
    // MARK: - 생명주기 메서드
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
        fetchMovieDetails()
    }
    
    // MARK: - UI 설정
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    // MARK: - 네비게이션 바 설정
    private func setNavigationBarStyle() {
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - 좋아요 설정
    private func setupLikeCount() {
        likeCount = Int.random(in: 1001...3001)
        updateLikeButtonTitle()
    }
    
    // MARK: - 버튼 액션 설정
    private func buttonActions() {
        movieDetailView.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        movieDetailView.bookingButton.addTarget(self, action: #selector(bookingButtonTapped), for: .touchUpInside)
        movieDetailView.trailerButton.addTarget(self, action: #selector(playTrailer), for: .touchUpInside)
        movieDetailView.shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 버튼 애니메이션
    private func animateButtonPress(_ button: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    // MARK: - 좋아요 버튼 텍스트 업데이트
    private func updateLikeButtonTitle() {
        let updatedTitle = "♥ \(likeCount.formatted())" // 형식화된 숫자
        movieDetailView.likeButton.setTitle(updatedTitle, for: .normal)
    }
    
    // MARK: - 버튼 클릭 액션들
    @objc func bookingButtonTapped() {
        let selectDateVC = SelectDateViewController()
        guard let movieData = movieData else { return }

        selectDateVC.setSelectDateViewData(movieData) // selectDataVC에 영화 정보 전달
        navigationController?.pushViewController(selectDateVC, animated: true)
    }
    
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
    
    @objc private func shareButtonTapped() {
        let appURL = "https://github.com/SpartaCoding-iOS5/LuckVii"
        
        // 클립보드에 URL 복사
        UIPasteboard.general.string = appURL
        
        // 알림을 사용자에게 보여줌
        let alert = UIAlertController(title: "URL 복사 완료!", message: "앱 링크가 복사되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - 예고편 버튼 누를 때
    @objc private func playTrailer() {
        Task {
            do {
                guard let movieId: Int = movie?.id else { throw AppError.dataError(.noIdData) }
                // 예고편 데이터 요청
                let videoData: VideoData = try await NetworkManager.shared.fetchData(
                    endpoint: .video(id: movieId),
                    parameters: NetworkManager.URLParameterSet.common
                )
                // YouTube 영상 찾기
                guard let video = videoData.results.first else { throw AppError.networkError(.noData) }//id에 맞는 videoData가 없다면 error
                let url = try video.getVideoURL()//url 생성 시도
                let safariVC = SFSafariViewController(url: url)// Safari로 예고편 재생
                
                present(safariVC, animated: true)
            } catch AppError.dataError(.noIdData) {
                showAlert(message: "영화 데이터가 유효하지 않습니다.")
            } catch AppError.convertError(.URLMakingError){
                showAlert(message: "예고편 URL을 가져올 수 없습니다.")
            } catch {
                showAlert(message: "예고편이 준비되지 않았습니다.")
            }
        }
    }
    
    // MARK: - 영화 상세 정보 가져오는 함수
    private func fetchMovieDetails() {
        Task {
            do {
                guard let movieId: Int = movie?.id else { throw AppError.dataError(.noIdData) }
                // 영화 상세 정보 요청
                let detailData: DetailData = try await NetworkManager.shared.fetchData(
                    endpoint: .detail(id: movieId),
                    parameters: NetworkManager.URLParameterSet.common
                )
                
                let releaseDateString = detailData.releaseDate
                let runtime: Int = detailData.runtime
                let ageRating: String = detailData.adult ? "19 성인 관람가" : "전체 관람가"
                
                DateFormatter.shared.dateFormat = "yyyy-MM-dd" // releaseDate의 입력 포맷
                if let releaseDate = DateFormatter.shared.date(from: releaseDateString) {
                    // 출력 형식으로 다시 변경
                    DateFormatter.shared.dateFormat = "yyyy.MM.dd" // 출력 포맷
                    let formattedReleaseDate = DateFormatter.shared.string(from: releaseDate)
                    let formattedString = "\(formattedReleaseDate) 개봉 | \(ageRating) | \(runtime)분"
                    // 영화 정보 레이블 업데이트
                    movieDetailView.movieInformationLabel.text = formattedString
                } else {
                    // 변환 실패 처리
                    movieDetailView.movieInformationLabel.text = "날짜 정보 없음 | \(ageRating) | \(runtime)분"
                }
            } catch AppError.dataError(.noIdData) {
                showAlert(message: "영화 데이터가 유효하지 않습니다.")
            } catch {
                showAlert(message: "영화 정보를 가져오는 데 실패했습니다: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - 예고편 예외 상황 알림창
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "죄송합니다.", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - 영화 상세 정보 뷰 설정
extension MovieDetailViewController {
    func setDetailViewData(_ dataSource: MovieDataSource) {
        movieDetailView.setDetailView(dataSource)
        self.movieData = dataSource 
        self.movie = dataSource.movieData // movie 객체 설정 추가함
        print("\(dataSource)")
    }
}
