//
//  DropdownModel.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/12/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import Foundation

class DropdownModel: NSObject {

    
    var dbId = ""
    var id = ""
    var cid = ""
    var cnid = ""
    var na = ""
    init(dbId:String ,id:String,cid:String ,cnid:String,na:String) {
        self.dbId = dbId
        self.id = id
        self.cid = cid
        self.cnid = cnid
        self.na = na
    }
}
