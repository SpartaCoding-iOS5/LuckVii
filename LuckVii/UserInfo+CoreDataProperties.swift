//
//  UserInfo+CoreDataProperties.swift
//  LuckVii
//
//  Created by jae hoon lee on 12/17/24.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var name: String?
    @NSManaged public var birth: String?

}

extension UserInfo : Identifiable {

}
