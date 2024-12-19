//
//  ReservationDetailViewController.swift
//  LuckVii
//
//  Created by Jamong on 12/19/24.
//

import UIKit
import SnapKit

class ReservationDetailViewController: UIViewController {

   // MARK: - Properties

    private let detailView = ReservationDetailView()
    private var reservationData: ReservationInfoData?
   
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
       

   }

   // MARK: - Setup
   private func setupUI() {
       navigationItem.title = "예매 상세 내역"
   }
    
    // MARK: - Configuration
    func configure(with reservation: ReservationInfoData) {
        print("Configuring with reservation:", reservation) // 전달된 데이터를 확인
        self.reservationData = reservation
        detailView.configure(with: reservation)
    }
}
