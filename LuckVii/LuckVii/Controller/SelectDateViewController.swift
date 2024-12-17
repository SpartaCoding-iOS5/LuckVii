//
//  SelectDateViewController.swift
//  LuckVii
//
//  Created by 손겸 on 12/17/24.
//

import UIKit
import SnapKit

class SelectDateViewController: UIViewController {
    let selectDateView = SelectDateView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDatePickerView()
    }
    
    // 달력 뷰
    private func setupDatePickerView() {
        [
            selectDateView
        ].forEach { view.addSubview($0) }
        
        // 제약 조건
        selectDateView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


