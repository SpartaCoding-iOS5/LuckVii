//
//  View.swift
//  LuckVii
//
//  Created by 김손겸 on 12/13/24.
//

import UIKit
import SnapKit

class MovieDetailView: UIView {
    let movieDescriptionView = MovieDescriptionView() // 영화 소개글 뷰
    let scrollview = UIScrollView()
    let contentView = UIView()
    
    // 포스터 이미지 뷰
    private let posterImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.backgroundColor = .lightGray
        
        // 제목 잘 보이게 그라데이션 추가
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageview.bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor, // 상단은 투명으로
            UIColor.black.withAlphaComponent(1.0).cgColor // 하단은 반투명 검정
        ]
        gradientLayer.locations = [0.3, 1.0] // 그라데이션 시작 위치 조정
        imageview.layer.addSublayer(gradientLayer)
        
        // 레이아웃이 변경될 때마다 그라데이션 레이어의 크기를 업데이트
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
    // 예고편 재생 버튼
    public let trailerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("예고편 재생 ▶︎", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    // 영화 이름 레이블
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "진격의 거인"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.textColor = .white
        label.applyShadow()
        
        return label
    }()
    
    // 영화 정보 레이블
    public let movieInformationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.applyShadow()
        
        return label
    }()
    
    // 좋아요 버튼
    public let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("♥ 2,999", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    // 공유 버튼
    public let shareButton: UIButton = {
        let button = UIButton(type: .system)
        let shareIcon = UIImage(systemName: "square.and.arrow.up") // 공유 심볼
        let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        button.setImage(shareIcon?.withConfiguration(configuration), for: .normal) // 심볼 크기 설정
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .lightGray
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    // 예매하기 버튼 추가
    public let bookingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("예매하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 14
        button.backgroundColor = .systemGreen
        
        return button
    }()
    
    // 버튼 스택뷰
    public let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
    
    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        scrollview.showsVerticalScrollIndicator = false // 세로 스크롤 없애기
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // 모든 UI를 뷰에 추가
    private func setupUI() {
        
        addSubview(scrollview)
        scrollview.addSubview(contentView)
        
        [
            posterImageView,
            movieNameLabel,
            movieInformationLabel,
            buttonStackView,
            trailerButton,
            movieDescriptionView
            
        ].forEach { contentView.addSubview($0) }
        
        [
            likeButton,
            shareButton,
            bookingButton
            
        ].forEach { buttonStackView.addArrangedSubview($0) }
        
        // 제약 조건
        scrollview.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints{
            $0.edges.equalTo(scrollview)
            $0.width.equalTo(scrollview)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
            $0.height.equalTo(contentView.snp.width).multipliedBy(1.5) // 영화 포스터 높이를 가로 길이의 1.5배로 설정
        }
        
        trailerButton.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).multipliedBy(0.65)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        
        movieNameLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).multipliedBy(0.8) // 항상 포스터 아래의 20% 지점에 영화 이름 배치
            $0.centerX.equalToSuperview()
        }
        
        movieInformationLabel.snp.makeConstraints {
            $0.top.equalTo(movieNameLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        likeButton.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(50)
        }
        
        shareButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
        
        bookingButton.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.width.equalTo(180)
        }
        movieDescriptionView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    // 레이아웃 변경될 때마다 그라데이션 레이어 크기 변경
    override func layoutSubviews() {
        super.layoutSubviews()
        // 그라데이션 레이어의 프레임을 이미지뷰의 bounds에 맞게 업데이트
        guard let gradientLayer = posterImageView.layer.sublayers?.first as? CAGradientLayer else { return }
        gradientLayer.frame = posterImageView.bounds
    }
}

// UILabel에 그림자 효과 적용 메서드
extension UILabel {
    func applyShadow(color: UIColor = .black,
                     offset: CGSize = CGSize(width: 2, height: 2),
                     opacity: Float = 0.7,
                     radius: CGFloat = 3) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}

extension MovieDetailView {
    
    func setDetailView(_ dataSource: MovieDataSource) {
        movieNameLabel.text = dataSource.movieData.title
        movieDescriptionView.descriptionLabel.text = dataSource.movieData.overview
        posterImageView.image = dataSource.image
    }
}
