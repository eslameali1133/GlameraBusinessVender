//
//  AddEditEmpVC.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/13/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftyJSON
class AddEditEmpVC: UIViewController {
    
    @IBOutlet weak var ActiveStauts: UISwitch!
    @IBOutlet weak var TXT_Arname: HoshiTextField!
    @IBOutlet weak var TXT_Enname: HoshiTextField!
    @IBOutlet weak var TXT_Phone: HoshiTextField!
    
    var isEdit = false
    var arname = ""
    var enName = ""
    var phone = ""
    var status = false
    var empid = ""
     var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        if isEdit == true
        {
            SetData()
        }
        http.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func SetData()
    {
        TXT_Phone.text = phone
        TXT_Arname.text = arname
        TXT_Enname.text = enName
        if status == true {
            ActiveStauts.setOn(true, animated: false)
        } else {
            ActiveStauts.setOn(false, animated: false)
        }
        
    }
    
    func AddNew()
    {
        let Acoumdid =  AppCommon.sharedInstance.getJSON("Profiledata")["AccountSetupId"].stringValue
        let token_type = AppCommon.sharedInstance.getJSON("Profiledata")["token_type"].stringValue
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["access_token"].stringValue
        let status:Bool = ActiveStauts.isOn ? true : false
        
        let params = ["AccountSetupId":Acoumdid,"NameEn":TXT_Enname.text!,"NameAr":TXT_Arname.text!,"MobileNumber":TXT_Phone.text!,"Status":status] as [String: Any]
        let headers = ["Content-Type": "application/json","Authorization" : "\(token_type) \(AccessToken)"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.EmployeeAdd, method: .post, parameters: params, tag: 1, header: headers)
    }
    func EditEmp()
    {
        let Acoumdid =  AppCommon.sharedInstance.getJSON("Profiledata")["AccountSetupId"].stringValue
        let token_type = AppCommon.sharedInstance.getJSON("Profiledata")["token_type"].stringValue
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["access_token"].stringValue
        let status:Bool = ActiveStauts.isOn ? true : false
       
        let params = ["Id":empid,"AccountSetupId":Acoumdid,"NameEn":TXT_Enname.text!,"NameAr":TXT_Arname.text!,"MobileNumber":TXT_Phone.text!,"Status":status] as [String: Any]
        
        let headers = ["Content-Type": "application/json","Authorization" : "\(token_type) \(AccessToken)"]
        
        
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.EmployeeEdit, method: .post, parameters: params, tag: 1, header: headers)
    }
    @IBAction func Btn_Save(_ sender: Any) {
        if validation()
        {
        if isEdit == true
        {
            EditEmp()
        }else{
            AddNew()
        }
        }
    }
    
    func validation () -> Bool {
        var isValid = true
        
        
        if TXT_Arname.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("ArNAmeValid"))
            isValid = false
        }
        
        if TXT_Enname.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("EnNAmeValid"))
            isValid = false
        }
        if TXT_Phone.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Phone field cannot be left blank"))
            isValid = false
        }
        return isValid
    }
}
extension AddEditEmpVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let json = JSON(dictResponse)
        
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        // add
        if Tag == 1 {
            let status = JSON(json["State"])
            print(json["status"])
            if status.stringValue  == "100" {
                Loader.showError(message: (AppCommon.sharedInstance.localization("done")))
                navigationController?.popViewController(animated: true)
            } else {
                Loader.showError(message: (forbiddenMail))
            }
        }
        
        // edit
        if Tag == 2 {
            let status = JSON(json["State"])
            print(json["status"])
            if status.stringValue  == "100" {
                Loader.showError(message: (AppCommon.sharedInstance.localization("done")))
                
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
