//
//  UserInfo+CoreDataProperties.swift
//  LuckVii
//
//  Created by 박진홍 on 12/20/24.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var birth: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var nickName: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var reservation: NSSet?

}

// MARK: Generated accessors for reservation
extension UserInfo {

    @objc(addReservationObject:)
    @NSManaged public func addToReservation(_ value: ReservationInfo)

    @objc(removeReservationObject:)
    @NSManaged public func removeFromReservation(_ value: ReservationInfo)

    @objc(addReservation:)
    @NSManaged public func addToReservation(_ values: NSSet)

    @objc(removeReservation:)
    @NSManaged public func removeFromReservation(_ values: NSSet)

}

extension UserInfo : Identifiable {

}
