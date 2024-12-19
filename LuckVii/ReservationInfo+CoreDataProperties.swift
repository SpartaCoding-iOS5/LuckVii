//
//  ReservationInfo+CoreDataProperties.swift
//  LuckVii
//
//  Created by Jamong on 12/20/24.
//
//

import Foundation
import CoreData


extension ReservationInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReservationInfo> {
        return NSFetchRequest<ReservationInfo>(entityName: "ReservationInfo")
    }

    @NSManaged public var title: String?
    @NSManaged public var dateTime: String?
    @NSManaged public var theater: String?
    @NSManaged public var posterImage: Data?
    @NSManaged public var ticketCount: Int16
    @NSManaged public var tickets: TicketInfo?

}

extension ReservationInfo : Identifiable {

}
