//
//  ReservationInfo+CoreDataProperties.swift
//  LuckVii
//
//  Created by 박진홍 on 12/20/24.
//
//

import Foundation
import CoreData


extension ReservationInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReservationInfo> {
        return NSFetchRequest<ReservationInfo>(entityName: "ReservationInfo")
    }

    @NSManaged public var dateTime: String?
    @NSManaged public var posterImage: Data?
    @NSManaged public var theater: String?
    @NSManaged public var ticketCount: Int16
    @NSManaged public var title: String?
    @NSManaged public var price: Int32
    @NSManaged public var seatNumber: String?

}

extension ReservationInfo : Identifiable {

}
