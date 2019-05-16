//
//  ForgetPasswordVC.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/12/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftyJSON
class ForgetPasswordVC: UIViewController {

     @IBOutlet weak var TXT_Email: HoshiTextField!
     var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
  http.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func SendEmail()
    {
        let params = ["Email":TXT_Email.text!] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.ForgetPassword, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    @IBAction func Forget_Btn(_ sender: Any) {
        if validation()
        {
        SendEmail()
        }
    }
    func validation () -> Bool {
        var isValid = true
        
        
        if !isValidEmail(testStr: TXT_Email.text!) { Loader.showError(message: AppCommon.sharedInstance.localization("Invalid email address"))
            isValid = false
        }
        
       
        
       
        
        return isValid
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
extension ForgetPasswordVC: HttpHelperDelegate {
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
                 Loader.showSuccess(message: AppCommon.sharedInstance.localization("done"))
                self.navigationController?.popViewController(animated: true)
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

