//
//  UserDataManager+Extension.swift
//  LuckVii
//
//  Created by 박진홍 on 12/20/24.
//

import UIKit
import CoreData

extension UserDataManger {
    func saveReservation(_ reservation: ReservationInfoData, for user: UserInfo) {
        // ReservationInfo 객체 생성
        let reservationInfo = ReservationInfo(context: context)
        
        // 예약 정보 설정
        reservationInfo.setValue(reservation.title, forKey: "title")
        reservationInfo.setValue(reservation.dateTime, forKey: "dateTime")
        reservationInfo.setValue(reservation.theater, forKey: "theater")
        reservationInfo.setValue(reservation.posterImage?.pngData(), forKey: "posterImage")
        reservationInfo.setValue(reservation.ticketCount, forKey: "ticketCount")
        reservationInfo.price = Int32(reservation.price)
        reservationInfo.seatNumber = reservation.seatNumber
        
        // User와 ReservationInfo 관계 설정
        reservationInfo.userInfo = user  // ReservationInfo의 user 속성에 User 객체 할당
        user.addToReservation(reservationInfo)  // User의 reservations 관계에 추가
        
        // 컨텍스트 저장
        saveContext()
    }
    
    // 특정 User의 예매 정보 불러오기
    func fetchReservations(for user: UserInfo) -> [ReservationInfoData] {
        let fetchRequest = NSFetchRequest<ReservationInfo>(entityName: "ReservationInfo")
        
        // User에 속한 ReservationInfo만 가져오기 위해 predicate 추가
        fetchRequest.predicate = NSPredicate(format: "userInfo == %@", user)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.map { reservation in
                return ReservationInfoData(
                    title: reservation.title ?? "",
                    dateTime: reservation.dateTime ?? "",
                    theater: reservation.theater ?? "",
                    posterImage: reservation.posterImage?.toImage() ?? UIImage(systemName: "x.circle"),
                    ticketCount: Int(reservation.ticketCount),
                    price: Int(reservation.price),
                    seatNumber: reservation.seatNumber ?? ""
                )
            }
        } catch {
            print("예매 내역 조회 실패: \(error)")
            return []
        }
    }
}
