//
//  ReservationInfo.swift
//  LuckVii
//
//  Created by Jamong on 12/19/24.
//
//

import Foundation
import SwiftData


@Model public class ReservationInfo {
    var title: String?
    var dateTime: String?
    var theater: String?
    var posterImage: Data?
    var ticketCount: Int16? = 0
    @Relationship(inverse: \TicketInfo.reservation) var tickets: TicketInfo?
    public init() {

    }
    

#warning("The property \"abstract\" on entity ReservationInfo is unsupported in SwiftData.")

}
