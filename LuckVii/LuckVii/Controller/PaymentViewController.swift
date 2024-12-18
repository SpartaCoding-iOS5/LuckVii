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
        setupAction()
    }

    // 네비게이션 설정
    private func configureNavigation() {
        navigationItem.title = "결제"
    }
    // MARK: - 레이아웃 설정

    private func configureUI() {
        view.backgroundColor = .lightGray
    }

    // 액션 연결
    private func setupAction() {
        paymentView.termsAgreementButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.didTapAreementButton()

        }, for: .touchUpInside)
    }

    // 버튼 액션
    func didTapAreementButton() {
        self.navigationController?.modalPresentationStyle = .fullScreen
        present(AgreementTermsViewController(), animated: true)
    }
}
