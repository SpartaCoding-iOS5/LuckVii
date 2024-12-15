//
//  View.swift
//  LuckVii
//
//  Created by 김손겸 on 12/13/24.
//

import UIKit
import SnapKit


class MovieDetailView: UIView {
    
    // 포스터 이미지
    private let posterImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.backgroundColor = .lightGray
        
        return imageview
    }()
    
    // 영화 이름 레이블
    private let movieName: UILabel = {
        let label = UILabel()
        label.text = "영화 이름"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    // 영화 정보 레이블
    private let movieInformation: UILabel = {
        let label = UILabel()
        label.text = "2024.12.15 개봉 | 12세 이상 관람가 | 106분"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()

    // 좋아요 버튼
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("♥ 9,999", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return button
    }()
    
    // 공유 버튼
    private let shareButton: UIButton = {
        let button = UIButton()
        let shareIcon = UIImage(systemName: "square.and.arrow.up") // 공유 심볼
        button.setImage(shareIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .gray
        button.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        
        return button
    }()
    
    // 예매하기 버튼 추가
    private let bookingButton: UIButton = {
        let button = UIButton()
        button.setTitle("예매할까?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 73, green: 198, blue: 144, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    
    
        
    }


