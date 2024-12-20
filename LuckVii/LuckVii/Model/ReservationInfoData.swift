//
//  UserInfoData.swift
//  LuckVii
//
//  Created by jae hoon lee on 12/17/24.
//
import CoreData
import UIKit

struct ReservationInfoData {
    let title: String
    let dateTime: String
    let theater: String
    let posterImage: UIImage?
    let ticketCount: Int
    let price: Int
    let seatNumber: String
    
    func setPriceAndSeat(_ price: Int, seatNumber: String) -> ReservationInfoData {
        return ReservationInfoData(title: title, dateTime: dateTime, theater: theater, posterImage: posterImage, ticketCount: ticketCount, price: price, seatNumber: seatNumber)
    }
}

extension UIImage {
    func toData() -> Data? {
        return self.pngData()
    }
}

extension Data {
    func toImage() -> UIImage? {
        return UIImage(data: self)
    }
}
