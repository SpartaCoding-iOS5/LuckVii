//
//  AgreementTermsViewController.swift
//  LuckVii
//
//  Created by mun on 12/18/24.
//

import UIKit
import SnapKit

class AgreementTermsViewController: UIViewController {

    let agreementTermsView = AgreementTermsView()

    override func loadView() {
        view = agreementTermsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAction()
    }

    // 버튼 액션 연결
    private func setupAction() {
        agreementTermsView.agreementButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.didTapAreementButton()
        }, for: .touchUpInside)

        agreementTermsView.disagreementButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.didTapAreementButton()
        }, for: .touchUpInside)
    }

    // 버튼 액션 설정
    private func didTapAreementButton() {
        self.dismiss(animated: true)
    }
}
