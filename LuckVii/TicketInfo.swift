//
//  TicketInfo.swift
//  LuckVii
//
//  Created by Jamong on 12/19/24.
//
//

import Foundation
import SwiftData


@Model public class TicketInfo {
    var seatNumber: String?
    var price: Int32? = 0
    var reservation: ReservationInfo?
    public init() {

    }
    

#warning("The property \"abstract\" on entity TicketInfo is unsupported in SwiftData.")

}
