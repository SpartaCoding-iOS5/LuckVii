//
//  TicketInfo+CoreDataProperties.swift
//  LuckVii
//
//  Created by Jamong on 12/20/24.
//
//

import Foundation
import CoreData


extension TicketInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TicketInfo> {
        return NSFetchRequest<TicketInfo>(entityName: "TicketInfo")
    }

    @NSManaged public var seatNumber: String?
    @NSManaged public var price: Int32

}

extension TicketInfo : Identifiable {

}
