//
//  EmpCell.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/13/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit

class EmpCell: UITableViewCell {
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var btn_edit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
