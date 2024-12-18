//
//  AgreementTermsViewController.swift
//  LuckVii
//
//  Created by mun on 12/18/24.
//

import UIKit
import SnapKit

// AgreementTermsViewController Delegate 프로토콜
protocol AgreementTermsViewControllerDelegate: AnyObject {
    func updateButtonToggle(_ viewController: AgreementTermsViewController, isAgreed: Bool)
}

class AgreementTermsViewController: UIViewController {

    let agreementTermsView = AgreementTermsView()

    weak var delegate: AgreementTermsViewControllerDelegate?

    override func loadView() {
        view = agreementTermsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
    }

    // 버튼 액션 연결
    private func setupAction() {
        // 동의 버튼 클릭
        agreementTermsView.agreementButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.didTapAgreementButton()
            self.delegate?.updateButtonToggle(self, isAgreed: true) // delegate 지시

        }, for: .touchUpInside)

        // 비동의 버튼 클릭
        agreementTermsView.disagreementButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.didTapAgreementButton()
            self.delegate?.updateButtonToggle(self, isAgreed: false) // delegate 지시
        }, for: .touchUpInside)
    }

    // 버튼 액션 설정
    private func didTapAgreementButton() {
        self.dismiss(animated: true)
    }
}
