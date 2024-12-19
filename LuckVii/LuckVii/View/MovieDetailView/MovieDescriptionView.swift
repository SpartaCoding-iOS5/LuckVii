//
//  MovieDescriptionView.swift
//  LuckVii
//
//  Created by 손겸 on 12/16/24.
//

import UIKit
import SnapKit

class MovieDescriptionView: UIView {
    let contentView = UIView()
    let buttonStackView = UIStackView() // 스택뷰
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .justified

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
        
//        showsVerticalScrollIndicator = false // 세로 스크롤 없애기
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
    }
    
    // 더보기 버튼 표시 여부 업데이트 (글자 수로 결정)
    func updateDescription(with text: String) {
        print("텍스트 확인: \(text)")
        
        descriptionLabel.text = text
        refreshToggle() // 더보기 버튼의 상태를 업데이트
        setNeedsLayout()  // 레이아웃 갱신
        layoutIfNeeded()  // 즉시 레이아웃을 반영
    }
    
    // 더보기 버튼 표시 여부 업데이트
    private func refreshToggle() {
        guard let text = descriptionLabel.text else {
            toggleButton.isHidden = true
            return
        }
        
        // 글자 수가 120자 이상일 때만 버튼 표시
        let minTextLength = 90
        print("글자 수 확인: \(text.count)")  // 글자 수 확인 로그 추가
        if text.count > minTextLength {
            toggleButton.isHidden = false // 글자가 충분히 길면 더보기 버튼 표시
        } else {
            toggleButton.isHidden = true // 글자가 짧으면 더보기 버튼 숨김
        }
    }
}
