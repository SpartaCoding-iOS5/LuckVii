//
//  SelectDateView.swift
//  LuckVii
//
//  Created by 손겸 on 12/17/24.
//

import UIKit
import SnapKit

class SelectDateView: UIView {
    
    public let buttonTitles = ["9:00~10:50", "11:00~12:50", "13:00~14:50", "15:00~16:50", "17:00~18:50", "19:00~20:50", "21:00~22:50"]

    // 달력 뷰
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.minimumDate = Date() // 최소 날짜는 오늘로 설정
        picker.tintColor = .systemGreen
        picker.locale = Locale(identifier: "ko_KR")
        return picker
    }()
    
    // 시간 선택
    public let timePicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    // 선택된 시간
    public var selectedTime: String?

    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTimePicker()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        [
            datePicker,
            timePicker
        ].forEach { addSubview($0) }

        // 제약 조건
        datePicker.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
        
        timePicker.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(150)
        }
    }

    private func setupTimePicker() {
        timePicker.dataSource = self
        timePicker.delegate = self
    }
}



