//
//  RequestProgressCell.swift
//  MAAKMAAK
//
//  Created by apple on 2/20/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit

class ProgressOrders: UITableViewCell {

    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblServices: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func set(req:OrdersModel)  {
        self.lblOrderId.text = String(req.id)
        self.lblClientName.text =  req.clientData.nameEn
        
        let sevice = req.bookingServices
        let serviceName = sevice.map { $0.nameEn }.reduce("", +)
        let price = String(sevice.map { $0.price }.reduce(0, +))
        
        self.lblServices.text = serviceName
        self.lblPrice.text = price
        
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
