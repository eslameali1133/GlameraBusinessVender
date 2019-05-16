//
//  DefaultServicesModel.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/13/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit
import Foundation


class OrdersModel {
    let id, clientID: Int
    let startTime, endTime: String
    let accountSetupID, isPaid: Int
    let comment: String
    let slotID: Int
    let time: String
    var bookingStatus: Int
    let visitNo: Int?
    let totalTime: Int
    let bookingServices: [BookingService]
    let clientData :ClientModel

    init(id: Int, clientID: Int, startTime: String, endTime: String, accountSetupID: Int, isPaid: Int, comment: String, slotID: Int, time: String, bookingStatus: Int, visitNo: Int?, totalTime: Int, bookingServices: [BookingService],clientData:ClientModel) {
        self.id = id
        self.clientID = clientID
        self.startTime = startTime
        self.endTime = endTime
        self.accountSetupID = accountSetupID
        self.isPaid = isPaid
        self.comment = comment
        self.slotID = slotID
        self.time = time
        self.bookingStatus = bookingStatus
        self.visitNo = visitNo
        self.totalTime = totalTime
        self.bookingServices = bookingServices
        self.clientData = clientData
    }
    func copy(with zone: NSZone? = nil) -> Any {
//        let copy = AllSalons(TotalCount: TotalCount!, State: State!, salonsData: salonsData!)
        let copy = OrdersModel(id: id, clientID: clientID, startTime: startTime, endTime: endTime, accountSetupID: accountSetupID, isPaid: isPaid, comment: comment, slotID: slotID, time: time, bookingStatus: bookingStatus, visitNo: visitNo, totalTime: totalTime, bookingServices: bookingServices, clientData: clientData)
        
        return copy
    }
}
class ClientModel: Codable {
    let id: Int
    let name, nameAr, nameEn: String
    let gender: Int
    let phone: String?
    let mobile: String

    init(id: Int, name: String, nameAr: String, nameEn: String, gender: Int, phone: String?, mobile: String) {
        self.id = id
        self.name = name
        self.nameAr = nameAr
        self.nameEn = nameEn
        self.gender = gender
        self.phone = phone
        self.mobile = mobile
    }
}
class BookingService {
    let id: Int
    let nameAr,Date, nameEn, description, code: String
    let price, bookingMinutes: Int

    init(id: Int, nameAr: String, nameEn: String, description: String, code: String, price: Int, bookingMinutes: Int,Date: String) {
        self.id = id
        self.nameAr = nameAr
        self.nameEn = nameEn
        self.description = description
        self.code = code
        self.price = price
        self.bookingMinutes = bookingMinutes
        self.Date = Date
    }
}
