//
//  ViewController.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/10/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc =  OrdersVC.instantiate(fromAppStoryboard: .Orders)
        self.navigationController?.pushViewController(vc, animated: true)

        // Do any additional setup after loading the view.
        
    }


}

