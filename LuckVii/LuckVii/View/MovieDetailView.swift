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
    
    // 포스터 이미지 뷰
    private let posterImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.backgroundColor = .lightGray
        
        return imageview
    }()
    
    // 예고편 재생 버튼
    private let trailerButton: UIButton = {
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
    private let movieInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.12.15 개봉 | 19세 이상 관람가 | 106분"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.applyShadow()
        
        return label
    }()
    
    // 좋아요 버튼
    public let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("♥ 9,999", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    // 공유 버튼
    private let shareButton: UIButton = {
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
    private let bookingButton: UIButton = {
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
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // 모든 UI를 뷰에 추가
    private func setupUI() {
        [
            posterImageView,
            movieNameLabel,
            movieInformationLabel,
            buttonStackView,
            trailerButton,
            movieDescriptionView
            
        ].forEach { addSubview($0) }
        
        [
            likeButton,
            shareButton,
            bookingButton
            
        ].forEach { buttonStackView.addArrangedSubview($0) }
        
        // 제약 조건
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.65) // 영화 포스터 높이를 뷰 크기의 65%로 설정
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
