//
//  PersonalInfoVC.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/11/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftyJSON
class UserInfoVC: UIViewController {

    @IBOutlet weak var TXT_UserName: HoshiTextField!
    @IBOutlet weak var TXT_Password: HoshiTextField!
    @IBOutlet weak var TXT_ConfirmPassword: HoshiTextField!
    @IBOutlet weak var Btn_Next: UIButton!{
        didSet{
            Btn_Next.layer.cornerRadius = 7
            Btn_Next.layer.masksToBounds = true
        }
    }
     var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
 http.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func CheckEmailIsToken() {
        
        let params = ["UserName":TXT_UserName.text!] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.CheckUserName, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    func validation () -> Bool {
        var isValid = true
        
        
        if TXT_Password.text! != TXT_ConfirmPassword.text { Loader.showError(message: AppCommon.sharedInstance.localization("Password and Confirm password is not match!"))
            isValid = false
        }
        
        if (TXT_Password.text?.count)! < 6 { Loader.showError(message: AppCommon.sharedInstance.localization("Password must be at least 6 characters long"))
            isValid = false
        }
        if TXT_Password.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Password field cannot be left blank"))
            isValid = false
        }
        
        if TXT_UserName.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("UsernameValid"))
            isValid = false
        }
        return isValid
    }
    @IBAction func Btn_Next(_ sender: Any) {
        if validation(){
            CheckEmailIsToken()
            
        }
    }

}



extension UserInfoVC: HttpHelperDelegate {
    
    
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
        let Result =  JSON(json["Result"])
        
        let status =  JSON(json["State"])
        print(Result)
        print(status)
        let forbiddenMail : String = AppCommon.sharedInstance.localization("User Is token")
        if Tag == 1 {
            print(Result)
            print(status)
            if Result.boolValue == true
            {
                print(RegisterParameter)
                RegisterParameter["UserName"] = self.TXT_UserName.text!
                RegisterParameter["Password"] = self.TXT_Password.text!
                RegisterParameter["ConfirmPassword"] = self.TXT_ConfirmPassword.text!
                
                
                let Setting = UIStoryboard(name: "Auth", bundle: nil)
                let BusinessInfoVC = Setting.instantiateViewController(withIdentifier: "BusinessInfoVC") as! BusinessInfoVC
                self.navigationController?.pushViewController(BusinessInfoVC, animated: true)
            }
            else
            {
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
