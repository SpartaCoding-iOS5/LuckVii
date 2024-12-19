//
//  ReservationDetailViewController.swift
//  LuckVii
//
//  Created by Jamong on 12/19/24.
//

import UIKit
import SnapKit

final class ReservationDetailViewController: UIViewController {

   // MARK: - Properties
   private let detailView = ReservationDetailView()

   // MARK: - Initialization
   init() {
       super.init(nibName: nil, bundle: nil)
   }

   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   // MARK: - Lifecycle
   override func loadView() {
       view = detailView
   }

   override func viewDidLoad() {
       super.viewDidLoad()
       view.backgroundColor = .white
       setupUI()
       // 화면을 테스트하기 위해 임시 데이터를 configure로 전달
       detailView.configure(
           with: MovieReservation(
               title: "테스트 영화",
               dateTime: "2024.12.16 (월) 15:00~16:00 관람",
               theater: "테스트 극장",
               price: 0,
               posterImage: nil as String?
           )
       )
   }

   // MARK: - Setup
   private func setupUI() {
       navigationItem.title = "예매 상세 내역"
   }
}
