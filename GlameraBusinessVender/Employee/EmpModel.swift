//
//  EmpModel.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/13/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import Foundation

class EmpModelModel: NSObject {
    
    
    var Id = ""
    var NameEn = ""
    var NameAr = ""
    var MobileNumber = ""
    var Status = false
    init(Id:String ,NameEn:String,NameAr:String ,MobileNumber:String,Status:Bool) {
        self.Id = Id
        self.NameEn = NameEn
        self.NameAr = NameAr
        self.MobileNumber = MobileNumber
        self.Status = Status
    }
}
