//
//  EmployeeVC.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/13/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit
import SwiftyJSON

class EmployeeVC: UIViewController {
    var items = [EmpModelModel]()
     var http = HttpHelper()
    @IBOutlet weak var tblMoe: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        tblMoe.delegate = self
        tblMoe.dataSource = self
        tblMoe.changeView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         getData()
    }
    func getData()  {
        items.removeAll()
        let Acoumdid =  AppCommon.sharedInstance.getJSON("Profiledata")["AccountSetupId"].stringValue
        let token_type = AppCommon.sharedInstance.getJSON("Profiledata")["token_type"].stringValue
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["access_token"].stringValue
        let params = ["AccountSetupId":Acoumdid ] as [String: Any]
        let headers = ["Content-Type": "application/json","Authorization" : "\(token_type) \(AccessToken)"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.EmployeeGet, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    @IBAction func Btn_Addnew(_ sender: Any) {
        let Setting = UIStoryboard(name: "employee", bundle: nil)
                let AddEditEmpVC = Setting.instantiateViewController(withIdentifier: "AddEditEmpVC") as! AddEditEmpVC
                AddEditEmpVC.isEdit = false
        
                self.navigationController?.pushViewController(AddEditEmpVC, animated: true)
        
    }

}

extension EmployeeVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpCell", for: indexPath) as! EmpCell
        if SharedData.SharedInstans.getLanguage() == "en"
        {
             cell.lbl_name.text = items[indexPath.row].NameEn
        }else
        {
       cell.lbl_name.text = items[indexPath.row].NameAr
        }
        cell.btn_edit.addTarget(self, action: #selector(EditMyCar(_:)), for: .touchUpInside)
        cell.btn_edit.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func EditMyCar(_ sender: UIButton) {
        
        print(items[sender.tag].Id)

        let Setting = UIStoryboard(name: "employee", bundle: nil)
        let AddEditEmpVC = Setting.instantiateViewController(withIdentifier: "AddEditEmpVC") as! AddEditEmpVC
        AddEditEmpVC.isEdit = true
        AddEditEmpVC.status = items[sender.tag].Status
        AddEditEmpVC.arname = items[sender.tag].NameAr
        AddEditEmpVC.enName = items[sender.tag].NameEn
        AddEditEmpVC.phone = items[sender.tag].MobileNumber
         AddEditEmpVC.empid = items[sender.tag].Id
        self.navigationController?.pushViewController(AddEditEmpVC, animated: true)
    }
    
}


extension EmployeeVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        if Tag == 1 {
            
            let status = JSON(json["State"])
             let Data =  JSON(json["Employees"])
            print(Data)
            print(json["status"])
            if status.stringValue  == "100" {
                let result =  Data.arrayValue
                for json in result{
                    let obj = EmpModelModel(Id: json["Id"].stringValue, NameEn: json["NameEn"].stringValue, NameAr: json["NameAr"].stringValue, MobileNumber: json["MobileNumber"].stringValue, Status: json["Status"].boolValue)
                    items.append(obj)
                }
                
                tblMoe.reloadData()
                
                
            } else {
                Loader.showError(message: (forbiddenMail))
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
