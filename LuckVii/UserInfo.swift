//
//  UserInfo.swift
//  LuckVii
//
//  Created by Jamong on 12/19/24.
//
//

import Foundation
import SwiftData


@Model public class UserInfo {
    var birth: String?
    var email: String?
    var name: String?
    var nickName: String?
    var password: String?
    var phoneNumber: String?
    public init() {

    }
    

#warning("The property \"abstract\" on entity UserInfo is unsupported in SwiftData.")

}
