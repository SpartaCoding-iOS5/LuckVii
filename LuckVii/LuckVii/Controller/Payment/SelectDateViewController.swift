//
//  SelectDateViewController.swift
//  LuckVii
//
//  Created by 손겸 on 12/17/24.
//

import UIKit
import SnapKit

final class SelectDateViewController: UIViewController {
    var movie: MovieDataSource?

    private let selectDateView = SelectDateView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupNavigationBar()
        setupAction()
    }

    private func setupNavigationBar() {
        self.title = "상영 시간 선택"
        navigationController?.navigationBar.shadowImage = UIImage()
        let backButtonImage = UIImage(systemName: "arrow.left")

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: #selector(tappedPreviousButtion)
        )
    }

    // MARK: - 레이아웃 설정

    private func setupUI() {
        [
            selectDateView
        ].forEach { view.addSubview($0) }

        // 제약 조건
        selectDateView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // 버튼 액션 연결
    private func setupAction() {
        selectDateView.bottomButtonView.nextButton.addAction(UIAction { [weak self] _ in
            self?.tappedNextButton()
        }, for: .touchUpInside)

        selectDateView.bottomButtonView.previousButton.addAction(UIAction { [weak self] _ in
            self?.tappedPreviousButtion()
        }, for: .touchUpInside)
    }
}

extension SelectDateViewController {
    // 데이터 전달 받고 저장하는 메서드
    func setSelectDateViewData(_ dataSource: MovieDataSource) {
        movie = dataSource
    }
}

// MARK: - 액션 설정

extension SelectDateViewController {
    // 액션 설정
    func tappedNextButton() {
        let paymentVC = PaymentViewController()

        let dateFormatter = DateFormatter.shared
        let dateString = dateFormatter.string(from: selectDateView.datePicker.date)

        do {
            guard let movie = movie else { throw AppError.dataError(.noMovieData) }
            paymentVC.setPaymentViewMovieData(
                movie: movie,
                date: dateString,
                time: selectDateView.startTime[selectDateView.selectedItemOfIndex]
            )
            self.navigationController?.pushViewController(paymentVC, animated: true)
        } catch AppError.dataError(.noMovieData) {
            showAlert(with: "영화 정보가 없습니다.")
        } catch {
            showAlert(with: "알 수 없는 오류가 발생했습니다.")
        }
    }

    @objc func tappedPreviousButtion() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(
            title: "알림",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - SelecteDateView CollectionView 설정

extension SelectDateView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItemOfIndex = indexPath.item
        collectionView.reloadData()
    }
}

extension SelectDateView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        startTime.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as? TimeCollectionViewCell else { return UICollectionViewCell() }

        // 현재 셀이 선택된 셀인지 확인
        let isSelected = selectedItemOfIndex == indexPath.item ? true : false
        cell.configureData(
            startTime: startTime[indexPath.item],
            endTime: endTime[indexPath.item],
            isSelected: isSelected
        )

        return cell
    }
}
