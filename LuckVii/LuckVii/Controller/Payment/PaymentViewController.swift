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

    var movie: Movie?
    
    private var selectedDate: String = ""
    private var selectedTime: String = ""
    private var selectedTheater: String = ""
    private var moviePoster: UIImage?

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
        let backButtonImage = UIImage(systemName: "arrow.left")

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: #selector(didTapPreviousButton)
        )
    }

    // MARK: - 레이아웃 설정

    private func configureUI() {
        view.backgroundColor = .white
    }

    // MARK: - 액션 설정

    // 액션 연결
    private func setupAction() {
        paymentView.termsAgreementButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.didTapAreementButton()
        }, for: .touchUpInside)

        paymentView.bottomButtonView.previousButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.didTapPreviousButton()
        }, for: .touchUpInside)

        paymentView.bottomButtonView.nextButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.didTapNextButton()
        }, for: .touchUpInside)
    }

    // 동의 버튼 액션
    func didTapAreementButton() {
        let agreementTermsVC = AgreementTermsViewController()
        agreementTermsVC.delegate = self // delegate 설정

        self.navigationController?.modalPresentationStyle = .fullScreen
        present(agreementTermsVC, animated: true)
    }

    // 이전 버튼 액션
    @objc func didTapPreviousButton() {
        self.navigationController?.popViewController(animated: true)
    }


    // 결제 버튼 액션
    func didTapNextButton() {
        guard let movie = movie else { return }
        
        if paymentView.termsAgreementButton.isSelected {
            let paymentResultVC = PaymentResultViewController()
            paymentResultVC.configureData(
                data: paymentView.ticketCount,
                movie: movie,
                date: selectedDate,
                time: selectedTime,
                theater: selectedTheater,
                poster: moviePoster
            )
            self.navigationController?.pushViewController(paymentResultVC, animated: true)
        } else {
            let alert = UIAlertController(
                title: "약관 동의 필요",
                message: "결제를 진행하려면 약관에 동의해주세요.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
        }
    }
}

// MARK: - AgreementTermsViewController Delegate

extension PaymentViewController: AgreementTermsViewControllerDelegate {

    func updateButtonToggle(_ viewController: AgreementTermsViewController, isAgreed: Bool) {
        // 약관 동의 여부 분기 처리
        if isAgreed {
            paymentView.termsAgreementButton.isSelected = true // 약관 동의
        } else {
            paymentView.termsAgreementButton.isSelected = false // 약관 비동의
        }
    }
}

// MARK: - 데이터 설정

extension PaymentViewController {
    // 데이터 전달받고 저장하는 메서드
    func setPaymentViewMovieData(movie: MovieDataSource, date: String, time: String) {
        self.movie = movie.movieData
        self.selectedDate = date
        self.selectedTime = time
        self.selectedTheater = "영등포 럭비시네마 7층 1관"
        self.moviePoster = movie.image
        paymentView.setPaymentView(movie: movie, date: date, time: time)
    }
}
