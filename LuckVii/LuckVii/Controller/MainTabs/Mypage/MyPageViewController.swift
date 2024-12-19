//
//  MyPageViewController.swift
//  LuckVii
//
//  Created by Jamong on 12/17/24.
//

import UIKit
import SnapKit
import SwiftUI

final class MyPageViewController: UIViewController {

    // MypageView Components 가져오기
    private let myPageView = MyPageView()

    // 더미데이터
    private let dummyData: [MovieReservation] = [
        MovieReservation(
            title: "소방관",
            dateTime: "24.12.16 15:00~16:46",
            theater: "영등포 롯데시네마 1관 6층 (아이맥스) C9 2명",
            price: 60000,
            posterImage: nil
        ),
        MovieReservation(
            title: "신과함께",
            dateTime: "24.12.20 13:00~15:30",
            theater: "강남 CGV 2관 8층 A12 1명",
            price: 15000,
            posterImage: nil
        )
        // 더 많은 더미데이터 추가 가능
    ]

    override func loadView() {
        self.view = myPageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }

    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "마이페이지"
    }

    private func setupTableView() {
        myPageView.movieReservationTableView.delegate = self
        myPageView.movieReservationTableView.dataSource = self
        /// 테이블 뷰 높이 업데이트
        myPageView.updateTableViewHeight(numberOfRows: dummyData.count)
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieReservationCell.identifier, for: indexPath) as? MovieReservationCell else {
                return UITableViewCell()
            }

        let movieData = dummyData[indexPath.row]
        cell.configure(with: movieData)
        return cell
    }
}
