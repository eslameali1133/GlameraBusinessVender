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

var RegisterParameter:[String:Any] = ["FirstName":"","LastName":"","Email":"","BusinessName":"","Password":"","ConfirmPassword":"","BusinessType":"","BusinessSize":"","MobileNumber":"","UserName":"","Agreed":"","GlameraAdmin":true,"ConfirmBy":2,"CountryCode":""]
class PersonalInfoVC: UIViewController {

    @IBOutlet weak var TXT_Phone: HoshiTextField!
    @IBOutlet weak var TXT_Email: HoshiTextField!
    @IBOutlet weak var TXT_LastName: HoshiTextField!
    @IBOutlet weak var TXT_FirstName: HoshiTextField!
    @IBOutlet weak var lbl_phoneKey: UILabel!
       @IBOutlet weak var phoneKey: UITextField!
    @IBOutlet weak var Btn_Next: UIButton!{
        didSet{
            Btn_Next.layer.cornerRadius = 7
            Btn_Next.layer.masksToBounds = true
        }
    }
    
    let pickerPhoneKey = ToolbarPickerView()
    var PhoneKeyArray: [String] = ["+20","+966"]
    
     var http = HttpHelper()
    var phonekeyid = "+20"
    override func viewDidLoad() {
        super.viewDidLoad()
    http.delegate = self
         SetUpPicker()
        // Do any additional setup after loading the view.
    }
    
    
    func SetUpPicker(){
        
        phoneKey.inputView = pickerPhoneKey
        self.phoneKey.inputAccessoryView = self.pickerPhoneKey.toolbar
        pickerPhoneKey.delegate = self
        pickerPhoneKey.dataSource = self
        self.pickerPhoneKey.toolbarDelegate = self
        self.pickerPhoneKey.reloadAllComponents()
    }
    
    func CheckEmailIsToken() {
        
        let params = ["Email":TXT_Email.text!] as [String: Any]
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.CheckEmail, method: .post, parameters: params, tag: 1, header: headers)
    }
    
    func validation () -> Bool {
        var isValid = true
        
       
        if !isValidEmail(testStr: TXT_Email.text!) { Loader.showError(message: AppCommon.sharedInstance.localization("Invalid email address"))
            isValid = false
        }
        
        if (TXT_Phone.text?.count)! != 11  {
            Loader.showError(message: AppCommon.sharedInstance.localization("Phone number must be between 7 and 17 characters long"))
            isValid = false
        }
        
        if TXT_Phone.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Phone field cannot be left blank"))
            isValid = false
        }
        if TXT_LastName.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Name field cannot be left blank"))
            isValid = false
        }
        if TXT_FirstName.text! == "" { Loader.showError(message: AppCommon.sharedInstance.localization("Name field cannot be left blank"))
            isValid = false
        }
        
        return isValid
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    @IBAction func Btn_Next(_ sender: Any) {
        if validation(){
           CheckEmailIsToken()
            
        }
    }
    

}
extension PersonalInfoVC: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        
        self.view.endEditing(true)
    }
    
    func didTapCancel() {
       
            self.phoneKey.text = nil
            self.phoneKey.resignFirstResponder()
       
        self.view.endEditing(true)
    }

}

extension PersonalInfoVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
            return PhoneKeyArray.count+1
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            if row == 0{
                return AppCommon.sharedInstance.localization("SelectConuntrykey")
           
            }else {
                return PhoneKeyArray[row-1]
            }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
        
            if PhoneKeyArray.count != 0 {
                if row == 0 {
                    phoneKey.text = nil
                    
                }else {
                    lbl_phoneKey.text = PhoneKeyArray[row-1]
                    phoneKey.text = ""
                    phonekeyid = PhoneKeyArray[row-1]
                    
                }
            }
            
       
    }
}

extension PersonalInfoVC: HttpHelperDelegate {
    
    
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
      
        let json = JSON(dictResponse)
        let Result =  JSON(json["Result"])
       
        let status =  JSON(json["State"])
        print(Result)
        print(status)
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Email Is token")
        if Tag == 1 {
            print(Result)
            print(status)
            if Result.boolValue == true
            {
                 RegisterParameter["FirstName"] = self.TXT_FirstName.text!
                 RegisterParameter["LastName"] = self.TXT_LastName.text!
                 RegisterParameter["Email"] = self.TXT_Email.text!
                 RegisterParameter["MobileNumber"] = self.TXT_Phone.text!
                 RegisterParameter["CountryCode"] = self.phonekeyid
                
                let Setting = UIStoryboard(name: "Auth", bundle: nil)
                let UserInfoVC = Setting.instantiateViewController(withIdentifier: "UserInfoVC") as! UserInfoVC
                self.navigationController?.pushViewController(UserInfoVC, animated: true)
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
