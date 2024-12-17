//
//  SelectDateView.swift
//  LuckVii
//
//  Created by 손겸 on 12/17/24.
//

import UIKit
import SnapKit

// 달력 뷰
class SelectDateView: UIView {
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.minimumDate = Date() // 최소 날짜는 오늘로 설정
        picker.tintColor = .systemGreen
        picker.locale = Locale(identifier: "ko_KR")
        
        return picker
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
    
    private func setupUI() {
        [
            datePicker
        ].forEach { addSubview($0) }

        // 제약 조건
        datePicker.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
    }
}

