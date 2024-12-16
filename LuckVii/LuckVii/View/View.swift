//
//  View.swift
//  LuckVii
//
//  Created by 김손겸 on 12/13/24.
//

import UIKit
import SnapKit


class MovieDetailView: UIView {
    
    // 뒤로가기 버튼
//    private let backButton: UIButton = {
//        let button = UIButton(type: .system)
//        let icon = UIImage(systemName: "chevron.backward") // 뒤로가기 심볼
//        button.setImage(icon, for: .normal)
//        button.tintColor = .white
//        button.imageView?.contentMode = .scaleAspectFit
//        
//        return button
//    }()
    
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
    
    // 영화 소개 설명 뷰
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
어느 날 갑자기 출현한 정체불명의 식인종 거인들에 의해 인류의 태반이 잡아 먹히며 인류는 절멸 위기에 처한다.

목숨을 부지한 생존자들은 높이 50m의 거대한 삼중의 방벽 월 마리아, 월 로제, 월 시나를 건설하여 그 곳으로 도피, 방벽 내부에서 100여 년에 걸쳐 평화의 시대를 영위하게 된다.

그리고 100여 년이 지난 845년, 대부분 주민들이 오래도록 지속되어 온 평화에 안주하는 반면, 주인공 엘런 예거는 사람들이 거인들에게 둘러싸여 벽 안에서 가축같이 살아가는 세계에 커다란 불만을 느낀다. 그는 벽 밖의 세계로 나가서 세계를 자유롭게 누비며 탐험하는 것을 열망한다. 

거의 모두가 한결같이 벽 내부에서 주어진 평화를 만끽하는 것을 아무런 의심 없이 받아들이고 벽 밖으로 나아가고 싶어하는 자신을 별종으로 취급하고 이단시해도 매일 월 마리아 밖으로 방벽 외부 조사를 나가는 조사병단을 선망하며 꿈을 키워갔다.

소꿉친구들인 미카사 아커만, 아르민 알레르토와 셋이서 함께 거리를 거닐던 어느 날, 태어나 자란 고향인 시간시나 구 방벽에 돌연 나타난 초대형 거인이 뚫은 방벽의 구멍으로 들어온 거인들에게 수많은 민간인들이 죽임을 당하며 100년 동안 만들어졌던 벽 안 세계의 평화가 무너진다. 

어머니 카를라 예거가 거인에게 잡아 먹히는 참혹한 광경을 목도한 엘런은 복수심을 느끼고 지상에 있는 모든 거인들을 구축하겠다고 다짐한다.
"""
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .black
        textView.isEditable = false // 편집 불가 상태 설정 함. 읽기 모드
        textView.isScrollEnabled = true // 영화 설명이 길어질 경우 스크롤 가능
        textView.isSelectable = false // 텍스트 선택 불가능
        
        return textView
    }()
    
    // 버튼 스택뷰
    private let buttonStackView: UIStackView = {
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
            descriptionTextView,
            buttonStackView,
            trailerButton,
            //backButton
            
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
        
        descriptionTextView.snp.makeConstraints {
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
