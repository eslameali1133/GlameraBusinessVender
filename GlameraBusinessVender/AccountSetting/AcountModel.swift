//
//  AcountModel.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/16/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import Foundation


class AcountModel: NSObject {
    
    
    var Id = ""
    var CountryId = ""
    var AreaId = ""
    var MobileNumber = ""
    var BusinessSize = ""
    
   
    var CityId = ""
    var BusinessType = ""
    var CompanyName = ""
    var Address = ""
   
    
    
    init(Id:String ,CountryId:String,AreaId:String ,MobileNumber:String,BusinessSize:String,CityId:String,BusinessType:String,Address:String,CompanyName:String) {
        self.Id = Id
        self.CountryId = CountryId
        self.AreaId = AreaId
        self.MobileNumber = MobileNumber
        self.BusinessSize = BusinessSize
        self.CityId = CityId
        self.BusinessType = BusinessType
        
        
        self.MobileNumber = MobileNumber
        self.BusinessSize = BusinessSize
        self.CompanyName = CompanyName
        self.Address = Address
    }
}
