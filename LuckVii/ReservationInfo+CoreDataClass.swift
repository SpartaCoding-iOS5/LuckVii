//
//  ReservationInfo+CoreDataClass.swift
//  LuckVii
//
//  Created by Jamong on 12/19/24.
//
//

import Foundation
import CoreData

@objc(ReservationInfo)
public class ReservationInfo: NSManagedObject {
    public static let className = "ReservationInfo"
    public enum Key {
        static let title = "title"
        static let dateTime = "dateTime"
        static let theater = "theater"
        static let posterImage = "posterImage"
        static let ticketCount = "ticketCount"
        static let tickets = "tickets"
    }
}
