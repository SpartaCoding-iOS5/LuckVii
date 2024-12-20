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
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var nickName: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var reservation: ReservationInfo?

}

extension UserInfo : Identifiable {

}
