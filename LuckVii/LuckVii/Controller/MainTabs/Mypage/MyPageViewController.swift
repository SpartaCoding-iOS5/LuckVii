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

    private var reservations: [ReservationInfoData] = []

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
        let movieData = ReservationInfoData(
            title: reservation.title,
            dateTime: reservation.dateTime,
            theater: reservation.theater,
            posterImage: reservation.posterImage,
            ticketCount: reservation.ticketCount,
            price: reservation.price,
            seatNumber: reservation.seatNumber
        )
        print(movieData)
       
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
