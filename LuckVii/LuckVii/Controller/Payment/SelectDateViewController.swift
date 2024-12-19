//
//  SelectDateViewController.swift
//  LuckVii
//
//  Created by 손겸 on 12/17/24.
//

import UIKit
import SnapKit

class SelectDateViewController: UIViewController {
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
        self.title = "날짜/시간 선택"
        navigationController?.navigationBar.shadowImage = UIImage()
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
        selectDateView.nextButton.addAction(UIAction { [weak self] _ in
            self?.tappedNextButton()
        }, for: .touchUpInside)
    }

    // 선택된 시간 가져오기
    func getSelectedTime() -> String? {
        print(selectDateView.selectedTime)
        return selectDateView.selectedTime
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

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: selectDateView.datePicker.date)

        do {
            guard let movie = movie else { throw AppError.dataError(.noMovieData) }
            paymentVC.setPaymentViewMovieData(movie: movie, date: dateString, time: selectDateView.startTime[selectDateView.selectedItemOfIndex])
            self.navigationController?.pushViewController(paymentVC, animated: true)
        } catch AppError.dataError(.noMovieData) {
            //TODO 에러처리
        } catch {
            
        }
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TimeCollectionViewCell else { return UICollectionViewCell() }

        // 현재 셀이 선택된 셀인지 확인
        let isSelected = selectedItemOfIndex == indexPath.item ? true : false
        cell.configureData(startTime: startTime[indexPath.item], endTime: endTime[indexPath.item], isSelected: isSelected)

        return cell
    }
}
