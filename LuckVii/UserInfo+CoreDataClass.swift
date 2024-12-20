//
//  UserInfo+CoreDataClass.swift
//  LuckVii
//
//  Created by jae hoon lee on 12/17/24.
//
//

import Foundation
import CoreData

@objc(UserInfo)
public class UserInfo: NSManagedObject {
    public static let className = "UserInfo"
    public enum Key {
        static let email = "id"
        static let nickName = "nickName"
        static let password = "password"
        static let name = "name"
        static let birth = "birth"
        static let phoneNumber = "phoneNumber"
    }
}
