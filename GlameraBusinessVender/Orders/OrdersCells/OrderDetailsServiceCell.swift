//
//  OrderDetailsServiceCell.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/15/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit

class OrderDetailsServiceCell: UITableViewCell {

    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblServiceTime: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func set(req:BookingService)  {
//        self.lblServiceName.text = String(req.id)
        self.lblServiceName.text =  req.nameAr
        self.lblTime.text =  String(req.bookingMinutes)
        self.lblServiceTime.text =  String(req.Date)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
