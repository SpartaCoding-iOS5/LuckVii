//
//  SelectDateViewController.swift
//  LuckVii
//
//  Created by 손겸 on 12/17/24.
//

import UIKit
import SnapKit

class SelectDateViewController: UIViewController {
    private let selectDateView = SelectDateView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.title = "날짜/시간 선택"
    }
    
    private func setupUI() {
        [
            selectDateView
        ].forEach { view.addSubview($0) }
        
        // 제약 조건
        selectDateView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // 선택된 시간 가져오기
    func getSelectedTime() -> String? {
        return selectDateView.selectedTime
    }
}

extension SelectDateView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 시간만 선택하기 때문에 1개의 컴포넌트임
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return buttonTitles.count // 버튼 타이틀 수만큼 행을 추가함
    }
}

extension SelectDateView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return buttonTitles[row] // 각 행에 시간 제목 표시함
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTime = buttonTitles[row] // 선택된 시간을 저장함
    }
}


