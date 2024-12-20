//
//  UserDataManager+Extension.swift
//  LuckVii
//
//  Created by 박진홍 on 12/20/24.
//


extension UserDataManger {
    func saveReservation(_ reservation: ReservationInfoData) {
//        guard let entity = NSEntityDescription.entity(forEntityName: "ReservationInfo", in: context) else { return }
        
        let reservationInfo = ReservationInfo(context: context)
        reservationInfo.setValue(reservation.title, forKey: "title")
        reservationInfo.setValue(reservation.dateTime, forKey: "dateTime")
        reservationInfo.setValue(reservation.theater, forKey: "theater")
        // posterImage Data 변환 수정
        reservationInfo.setValue(reservation.posterImage?.pngData(), forKey: "posterImage")
        reservationInfo.setValue(reservation.ticketCount, forKey: "ticketCount")
        reservationInfo.price = Int32(reservation.price)//forKey에 String을 넣거나 Key를 정의할 필요 없어짐! 다음 사용에 참고하시면 좋아요
        reservationInfo.seatNumber = reservation.seatNumber
        saveContext()
    }
        
    
    // 예매 정보 불러오기
    func fetchReservations() -> [ReservationInfoData] {
        let fetchRequest = NSFetchRequest<ReservationInfo>(entityName: "ReservationInfo")
        
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
