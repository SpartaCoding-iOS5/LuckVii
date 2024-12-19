//
//  MovieDescriptionView.swift
//  LuckVii
//
//  Created by 손겸 on 12/16/24.
//

import UIKit
import SnapKit

class MovieDescriptionView: UIScrollView {
    let contentView = UIView()
    let buttonStackView = UIStackView() // 스택뷰
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    let toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        
        return button
    }()
    
    var isExpanded = false
    
    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupInitialDescriptionState()
        
        showsVerticalScrollIndicator = false // 세로 스크롤 없애기
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        [
            contentView,
            descriptionLabel,
            toggleButton
            
        ].forEach { addSubview($0) }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        toggleButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        toggleButton.addTarget(self, action: #selector(toggleText), for: .touchUpInside)
    }
    
    // 더보기, 접기 동작 메서드
    @objc private func toggleText() {
        isExpanded.toggle()
        
        if isExpanded {
            descriptionLabel.numberOfLines = 0
            toggleButton.setTitle("접기", for: .normal)
        } else {
            descriptionLabel.numberOfLines = 3
            toggleButton.setTitle("더보기", for: .normal)
        }
        
        refreshToggle()
        
        // 토클 클릭시 스크롤뷰 컨텐츠 크기 즉시 갱신
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // 더보기 버튼 표시 여부 업데이트
    private func refreshToggle() {
           // 텍스트가 비어있는지 확인
           if let text = descriptionLabel.text, text.isEmpty {
               toggleButton.isHidden = true
           } else {
               toggleButton.isHidden = false
           }
       }
       
       // 초기 상태 설정. 텍스트가 비어있으면 더보기 버튼 숨기기
       private func setupInitialDescriptionState() {
           refreshToggle()
       }
       
       // 새로운 텍스트가 설정될 때, 텍스트가 있다면 "더보기" 버튼 상태 업데이트
       func updateDescription(with text: String) {
           descriptionLabel.text = text
           refreshToggle()
       }
   }
