//
//  VerifyCodeVC.swift
//  MaakMaakAPP
//
//  Created by apple on 2/10/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON
import KKPinCodeTextField

class VerifyCodeVC: UIViewController {

 @IBOutlet weak var txtCode: KKPinCodeTextField!
    var UserId = ""
    var mobile = ""
    var verificationCode = ""
   
      var http = HttpHelper()
    
    @IBOutlet weak var BtnResend: UIButton!
    
    @IBOutlet weak var lbl_phoneNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCode.addTarget(self, action: #selector(didEnd(_:)),for: .editingChanged)
       
        http.delegate = self
        lbl_phoneNumber.text = mobile
//        SendVerificationCode()
        // Do any additional setup after loading the view.
    }
   
    @objc func didEnd(_ textField: UITextField) {
        if textField.text?.count == 6 {
            print("/////////////////////code sent")
           VerificationCode()
        }
    }
 
    @IBAction func Verfif_Btn(_ sender: Any) {
        
       VerificationCode()
    }
    
    
    
    @IBAction func ResendBtn(_ sender: Any) {
        SendVerificationCode()
    }
    
    func SendVerificationCode()
    {
        let params = ["UserId":UserId,"PhoneNumber":mobile] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.ResendVerifyPhoneCode, method: .post, parameters: params, tag: 1, header: headers)
    }

    func VerificationCode()
    {
        let params = ["UserId":UserId,"PhoneNumber":mobile ,"Code":txtCode.text!] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.VerifyPhone, method: .post, parameters: params, tag: 2, header: headers)
    }
    
    
   
}

extension VerifyCodeVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
       
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        if Tag == 1 {
            let status =  json["State"]
            let result =  json["Result"]
            print(result)
            print(status)
            
            print(json["status"])
            if status.stringValue  == "100" {
                
            } else {
                
                 Loader.showError(message: (forbiddenMail))
              
            }
            
            
        }
       
        if Tag == 2 {
            let status =  json["State"]
            let result =  json["Result"]
            print(result)
            print(status)
            
            print(json["status"])
            if status.stringValue  == "100" {
                print("done")
                Loader.showSuccess(message: AppCommon.sharedInstance.localization("RegisterDonw"))
                let sb = UIStoryboard(name: "Auth", bundle: nil)
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.window?.rootViewController = sb.instantiateInitialViewController()
                
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

