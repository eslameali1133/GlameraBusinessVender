//
//  LoginVC.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/12/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftyJSON
import Alamofire
class LoginVC: UIViewController {
    @IBOutlet weak var txt_Username: HoshiTextField!
    @IBOutlet weak var txt_Password: HoshiTextField!
    var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LogintBtn(_ sender: Any) {
        if validation()
        {
             AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        Login()
        }
    }
    
    func validation () -> Bool {
        var isValid = true
        
        
        if txt_Password.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Password field cannot be left blank"))
            isValid = false
        }
        
        if txt_Username.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("UsernameValid"))
            isValid = false
        }
        return isValid
    }
    func Login()
    {
       
        let headers = [  "Content-Type": "application/x-www-form-urlencoded"]
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Username")
        
        Alamofire.request(APIConstants.Login, method: .post, parameters: [:], encoding: "username=\(txt_Username.text!)&password=\(txt_Password.text!)&grant_type=password&accountSetupId=null", headers: headers)
            
            .responseJSON { (response) in
                
                switch response.result
                {
                case .failure(let error):
                    Loader.showError(message: (forbiddenMail))
                case .success(let value):
                    let jsn = JSON(value)
                    print(jsn)
                    if jsn["error"].stringValue == "1"
                    {
                        Loader.showError(message: jsn["error_description"].stringValue)
                        AppCommon.sharedInstance.dismissLoader(self.view)
                    }else{
                        print(jsn)
                        AppCommon.sharedInstance.saveJSON(json: jsn, key: "Profiledata")
                         print(AppCommon.sharedInstance.getJSON("Profiledata")["userId"].stringValue)
                        SharedData.SharedInstans.SetIsLogin(true)
                        AppCommon.sharedInstance.dismissLoader(self.view)
                        
                        /// move home
                      AppCommon.sharedInstance.ShowHome()
                        
                    }
                  
                }
                
                
        }
        
    }
    
}

extension LoginVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
        
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Username")
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



extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}
