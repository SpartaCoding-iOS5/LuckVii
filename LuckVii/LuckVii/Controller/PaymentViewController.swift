//
//  PaymentViewController.swift
//  LuckVii
//
//  Created by mun on 12/16/24.
//

import UIKit
import SnapKit

class PaymentViewController: UIViewController {

    let paymentView = PaymentView()

    // MARK: - 기본 설정

    override func loadView() {
        self.view = paymentView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        configureUI()
    }

    // 네비게이션 설정
    private func configureNavigation() {
        navigationItem.title = "결제"
    }
    // MARK: - 레이아웃 설정

    private func configureUI() {
        view.backgroundColor = .lightGray
    }
}
