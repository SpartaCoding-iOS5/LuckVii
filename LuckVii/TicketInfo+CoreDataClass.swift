//
//  TicketInfo+CoreDataClass.swift
//  LuckVii
//
//  Created by Jamong on 12/19/24.
//
//

import Foundation
import CoreData

@objc(TicketInfo)
public class TicketInfo: NSManagedObject {
    public static let className = "TicketInfo"
    public enum Key {
        static let seatNumber = "seatNumber"
        static let price = "price"
    }
}
