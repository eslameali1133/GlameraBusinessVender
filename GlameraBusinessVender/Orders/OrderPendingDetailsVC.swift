//
//  OrderPendingDetails.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/13/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit
import SwiftyJSON
class OrderPendingDetailsVC: UIViewController {

    var orderData :OrdersModel?
    @IBOutlet weak var lblBookingId: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var tblServices: UITableView!
    @IBOutlet weak var actionStack: UIStackView!
   
    var http = HttpHelper()
    @IBOutlet weak var btnArriveAndComplete: RoundedCornerButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillViewData()
        http.delegate = self
        translateButton()
        print("////////////////---> ",orderData?.bookingStatus ?? "" )
        tblServices.changeView()
//        self.navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
    }
    func translateButton()  {
        if orderData?.bookingStatus != 2 {
//            btnArriveAndComplete.setTitle(AppCommon.sharedInstance.localization("arrived"), for: .normal)
            btnArriveAndComplete.translation(key: "arrived")
        }else {
//            btnArriveAndComplete.setTitle(AppCommon.sharedInstance.localization("completed"), for: .normal)
            btnArriveAndComplete.translation(key: "completed")
        }
    }
    @IBAction func arrivecomplete(_ sender: UIButton) {
        var status = 2
        if orderData?.bookingStatus == 2 {
            status = 3
        }
        changeBookingStatus(Id: orderData!.id, Status: status, index: 0)
        translateButton()
    }
    @IBAction func noShow(_ sender: UIButton) {
        changeBookingStatus(Id: orderData!.id, Status: 5, index: 0)
    }
    @IBAction func cancel(_ sender: UIButton) {
        changeBookingStatus(Id: orderData!.id, Status: -1, index: 0)
    }
    
    func fillViewData()  {
        if let id = orderData?.id {
            self.lblBookingId.text = String(id)
        }
        self.lblClientName.text = orderData?.clientData.nameAr
        if orderData?.bookingStatus == 0 || orderData?.bookingStatus == -1 {
            actionStack.isHidden = true
        }
    }
    func changeBookingStatus(Id:Int,Status:Int,index:Int) {
        let token = APIConstants.token
        //self.orderStatus = Status
       // self.bookingIndex = index
        let params = ["Id":Id,"bookingStatus":Status]
        let headers = ["Authorization": "bearer \(token)",
            "Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.2))
        print("///////////////////",Id,Status)
        http.requestWithBody(url: APIConstants.BookingStatus, method: .post, parameters: params, tag: 1, header: headers)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension OrderPendingDetailsVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderData?.bookingServices.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "SearchForLocTableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsServiceCell", for: indexPath) as! OrderDetailsServiceCell
            let order :BookingService = (orderData?.bookingServices[indexPath.row])!
            cell.set(req: order)
            return cell
        
    }
}
extension OrderPendingDetailsVC : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
//        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        let json = JSON(dictResponse)
        print(json)
        let data = JSON(json["Result"])
        print(data)
                    let BookingServices =  JSON(data["BookingServices"])
        //            let BusinessSizes =  JSON(data["BusinessSizes"])
        let State = JSON(json["State"])
        if Tag == 1 {
            if State == 100 {
//             Loader.showError(message: )
             Loader.showSuccess(message: AppCommon.sharedInstance.localization("done"))
             self.navigationController?.popViewController(animated: true)
             self.dismiss(animated: true, completion: nil)
            }else{
                Loader.showError(message: AppCommon.sharedInstance.localization("error"))
            }
        }
        
    }
    
    func receivedErrorWithStatusCode(statusCode: Int) {
        print(statusCode)
        AppCommon.sharedInstance.alert(title: "Error", message: "\( AppCommon.sharedInstance.localization("errorconnect"))", controller: self, actionTitle: AppCommon.sharedInstance.localization("ok"), actionStyle: .default)
        AppCommon.sharedInstance.dismissLoader(self.view)
    }
    func retryResponse(numberOfrequest: Int) {
        
    }
}
