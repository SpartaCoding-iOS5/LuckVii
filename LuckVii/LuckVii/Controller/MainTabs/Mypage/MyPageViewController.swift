//
//  MyPageViewController.swift
//  LuckVii
//
//  Created by Jamong on 12/17/24.
//

import UIKit
import SnapKit
import SwiftUI


class MyPageViewController: UIViewController {
    
    // MypageView Components 가져오기
    private let myPageView = MyPageView()
    private var reservations: [ReservationInfoData] = []
    
//    // 더미데이터
//    private let dummyData: [MovieReservation] = [
//        MovieReservation(
//            title: "소방관",
//            dateTime: "24.12.16 15:00~16:46",
//            theater: "영등포 롯데시네마 1관 6층 (아이맥스) C9 2명",
//            price: 60000,
//            posterImage: nil
//        ),
//        MovieReservation(
//            title: "신과함께",
//            dateTime: "24.12.20 13:00~15:30",
//            theater: "강남 CGV 2관 8층 A12 1명",
//            price: 15000,
//            posterImage: nil
//        ),
//        // 더 많은 더미데이터 추가 가능
//    ]
    
    override func loadView() {
        self.view = myPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReserVations()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "마이페이지"
    }
    
    private func setupTableView() {
        myPageView.movieReservationTableView.delegate = self
        myPageView.movieReservationTableView.dataSource = self
    }
    
    private func loadReserVations() {
        // CoreData 예매 정보 가져옴
        reservations = UserDataManger.shared.fetchReservations()
        myPageView.updateTableViewHeight(numberOfRows: reservations.count)
        myPageView.movieReservationTableView.reloadData()
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieReservationCell.identifier, for: indexPath) as? MovieReservationCell else {
            return UITableViewCell()
        }
        
        let reservation = reservations[indexPath.row]
        let movieData = MovieReservation(
            title: reservation.title,
            dateTime: reservation.dateTime,
            theater: reservation.theater,
            price: reservation.tickets.reduce(0) { $0 + $1.price },
            posterImage: reservation.posterImage
        )
        
        cell.configure(with: movieData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let reservation = reservations[indexPath.row]
        let detailVC = ReservationDetailViewController()
        detailVC.configure(with: reservation)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
