//
//  RequestsVC.swift
//  MAAKMAAK
//
//  Created by M on 2/13/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON
class OrdersVC: UIViewController {

    var ordersData = [OrdersModel]()
    var filteredOrders = [OrdersModel]()
    var orderStatus = 0
    var bookingIndex = 0
    
    @IBOutlet weak var lblNoOrders: UILabel!
    @IBOutlet weak var tblRequests: UITableView!
    @IBOutlet weak var Segment: RounderSegmented!
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefersher), for: .valueChanged)
        return refresher
    }()
    var status = 0
    var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        setUpTableView()
        translateSegment()
        getAllOrders()
        navigationItem.largeTitleDisplayMode = .automatic
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllOrders()
    }
    func filterResult() {
        filteredOrders = (ordersData.map{$0.copy()} as? [OrdersModel])!
        if status == 0 {
            self.filteredOrders = ordersData.filter { $0.bookingStatus == 0 }
        }else if status == 1 {
            self.filteredOrders = ordersData.filter { $0.bookingStatus != 0 && $0.bookingStatus != -1 && $0.bookingStatus != 3}
        }else {
            self.filteredOrders = ordersData.filter { $0.bookingStatus == -1 && $0.bookingStatus != 3}
        }
        if filteredOrders.count == 0 {
            lblNoOrders.isHidden = false
        }else{
            lblNoOrders.isHidden = true
        }
    }

    @IBAction func btnSwitch(_ sender: UISegmentedControl) {
        filteredOrders = (ordersData.map{$0.copy()} as? [OrdersModel])!
        if sender.selectedSegmentIndex == 0 {
            status = 0
           self.filteredOrders = ordersData.filter { $0.bookingStatus == 0 }
        }else if sender.selectedSegmentIndex == 1 {
            status = 1
           self.filteredOrders = ordersData.filter { $0.bookingStatus != 0 && $0.bookingStatus != -1 && $0.bookingStatus != 3}
        }else if sender.selectedSegmentIndex == 2{
            status = 2
            self.filteredOrders = ordersData.filter { $0.bookingStatus == -1 && $0.bookingStatus != 3}
           
        }
        if filteredOrders.count == 0 {
            lblNoOrders.isHidden = false
        }else{
            lblNoOrders.isHidden = true
        }
        tblRequests.reloadData()
    }
    func translateSegment() {
        Segment.translation(key: "pending", segmentIndex: 0)
        Segment.translation(key: "inProgress", segmentIndex: 1)
        Segment.translation(key: "completed", segmentIndex: 2)
    }
    func setUpTableView() {
        tblRequests.register(PendingOrdersCell.nib, forCellReuseIdentifier: PendingOrdersCell.identifier)
        tblRequests.register(ProgressOrders.nib, forCellReuseIdentifier: ProgressOrders.identifier)
        tblRequests.register(CanceledOrders.nib, forCellReuseIdentifier: CanceledOrders.identifier)
//        refreshControl = UIRefreshControl()
//        navigationController?.navigationItem.addSubview(refresher)
//        self.extendedLayoutIncludesOpaqueBars = YES
        self.tblRequests.refreshControl = refresher
//        tblRequests.addSubview(refresher)
        refresher.bringSubviewToFront(self.view)
        refresher.tintColor = .white
        tblRequests.changeView()
//        tblRequests.addSubview(refresher)
//        NotificationCenter.default.addObserver(self, selector: #selector(refreshView), name: NSNotification.Name(rawValue: "refreshTableView"), object: nil)
    }
    
    fileprivate func LoadDta() {
        let token = APIConstants.token
        let params = ["AccountSetupId":14 ]
        let headers = ["Authorization": "bearer \(token)",
            "Content-Type": "application/json"]
       
        http.requestWithBody(url: APIConstants.GetOrders, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    func getAllOrders() {
         AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        LoadDta()
    }
    func changeBookingStatus(Id:Int,Status:Int,index:Int) {
        let token = APIConstants.token
        self.orderStatus = Status
        self.bookingIndex = index
        let params = ["Id":Id,"bookingStatus":Status ,"BookingServices": [ [ "Id": "", "EstimatedTime": "", "Note": " ", "EstimatedTimeUpdateStatus": true ] ]] as [String : Any]
        let headers = ["Authorization": "bearer \(token)",
            "Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.2))
        print("///////////////////",Id,Status)
        http.requestWithBody(url: APIConstants.BookingStatus, method: .post, parameters: params, tag: 2, header: headers)
        
    }
    @objc private func handleRefersher()
    {
        
        LoadDta()
        tblRequests.reloadData()
        self.refresher.endRefreshing()
    }
    @objc func refreshView(){
        tblRequests.reloadData()
    }
}
extension OrdersVC : UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if status == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PendingOrdersCell", for: indexPath) as! PendingOrdersCell
            let order :OrdersModel = filteredOrders[indexPath.row]
            print("PendingOrdersCell---->",filteredOrders[indexPath.row].bookingStatus)
            cell.selectTapped = { [unowned self] (selectedCell) -> Void in
                self.changeBookingStatus(Id: self.filteredOrders[indexPath.row].id, Status: 1, index: indexPath.row)
            }
            cell.cancelTapped = { [unowned self] (selectedCell) -> Void in
                self.changeBookingStatus(Id: self.filteredOrders[indexPath.row].id, Status: -1, index: indexPath.row)
            }
            cell.set(req: order)
            return cell
        }else if status == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressOrders", for: indexPath) as! ProgressOrders
            let order :OrdersModel = filteredOrders[indexPath.row]
            cell.set(req: order)
            print("ProgressOrders---->",filteredOrders[indexPath.row].bookingStatus)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CanceledOrders", for: indexPath) as! CanceledOrders
            let order :OrdersModel = filteredOrders[indexPath.row]
            cell.set(req: order)
            print("CanceledOrders--->",filteredOrders[indexPath.row].bookingStatus)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
            let vc =  OrderPendingDetailsVC.instantiate(fromAppStoryboard: .Orders)
            vc.orderData = filteredOrders[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)

        
    }
}
extension OrdersVC : HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        let json = JSON(dictResponse)
        print(json)
        let data = JSON(json["Result"])
        print(data)
        //            let BookingServices =  JSON(data["BookingServices"])
        //            let BusinessSizes =  JSON(data["BusinessSizes"])
        let State = JSON(json["State"])
        if Tag == 1 {
            if State == 100 {
            ordersData = [OrdersModel]()
            filteredOrders = [OrdersModel]()
//            print(BusinessSizes)
//            print(BusinessTypes)
            
            let OrdersData =  data.arrayValue
            for order in OrdersData {
            let clientJson = JSON(order["Client"])
            print(clientJson)
//            let resClient = order["Client"].dictionaryValue
            let tempClient = ClientModel(id: clientJson["Id"].intValue,
                                       name: clientJson["Name"].stringValue ,
                                       nameAr: clientJson["NameAr"].stringValue ,
                                       nameEn: clientJson["NameEn"].stringValue ,
                                       gender: clientJson["gender"].intValue ,
                                       phone: clientJson["phone"].stringValue ,
                                       mobile: clientJson["Mobile"].stringValue )
            print("tempClient--------->",tempClient.nameEn)
            var BookingServicesArray : [BookingService] = []
            let BookingServices =  order["BookingServices"].arrayValue
            for json in BookingServices {
                print("BookingServices---------->",json)
                let serviceDict = JSON(json["Service"])
//                let serviceDict = json["Service"].dictionaryValue
                let obj = BookingService(id: serviceDict["Id"].intValue ,
                                         nameAr: serviceDict["NameAr"].stringValue,
                                         nameEn: serviceDict["NameEn"].stringValue,
                                         description: serviceDict["Description"].stringValue,
                                         code: serviceDict["Code"].stringValue ,
                                         price: serviceDict["Price"].intValue,
                                         bookingMinutes: serviceDict["BookingMinutes"].intValue,
                                         Date: json["Date"].stringValue)
                
                BookingServicesArray.append(obj)
            }
                let tempOrder = OrdersModel(id: order["Id"].intValue ,
                                            clientID: order["ClientID"].intValue ,
                                            startTime: order["ClientID"].stringValue,
                                            endTime: order["EndTime"].stringValue,
                                            accountSetupID: order["AccountSetupID"].intValue,
                                            isPaid: order["IsPaid"].intValue,
                                            comment: order["Comment"].stringValue,
                                            slotID: order["SlotID"].intValue,
                                            time: order["Time"].stringValue,
                                            bookingStatus: order["bookingStatus"].intValue,
                                            visitNo: order["VisitNo"].intValue,
                                            totalTime: order["TotalTime"].intValue,
                                            bookingServices: BookingServicesArray,
                                            clientData: tempClient)
                ordersData.append(tempOrder)
                }
                filterResult()
                tblRequests.reloadData()
            }else{
                Loader.showError(message: (forbiddenMail))
            }
            
        }else if Tag == 2 {
            if State == 100 {
//                getAllOrders()
            self.filteredOrders[self.bookingIndex].bookingStatus = orderStatus
            filterResult()
//                getAllOrders()
            self.tblRequests.reloadData()
//                getAllOrders()
//            viewDidLoad()
//            AppCommon.sharedInstance.alert(title: "Done", message: "\( AppCommon.sharedInstance.localization("ConfirmBooking"))", controller: self, actionTitle: AppCommon.sharedInstance.localization("ok"), actionStyle: .default)
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
