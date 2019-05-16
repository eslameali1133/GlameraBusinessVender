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
class BusinessInfoVC: UIViewController {
    @IBOutlet weak var txt_BusinessName: HoshiTextField!
    @IBOutlet weak var txt_BusinessType: HoshiTextField!
    @IBOutlet weak var txt_NumberOf: HoshiTextField!
    
    @IBOutlet weak var Btn_Next: UIButton!{
        didSet{
            Btn_Next.layer.cornerRadius = 7
            Btn_Next.layer.masksToBounds = true
        }
    }
    
    let pickerBusinessType = ToolbarPickerView()
    let pickerEmpSize = ToolbarPickerView()
    
    var BusinessTypeArray: [DropdownModel] = [DropdownModel]()
    var EmpSizeArray: [DropdownModel] = [DropdownModel]()
    
    var pickerslectnum = 0 // flage to different betwwen Deopdown
    var BusinessTypeID = ""
    var EmpSizeID = ""
    var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupNumEmpalyee()
        SetupType()
        SetUpPicker()
        http.delegate = self
        GetAll()
        // Do any additional setup after loading the view.
    }
    
    func SetUpPicker(){
        
        txt_BusinessType.inputView = pickerBusinessType
        self.txt_BusinessType.inputAccessoryView = self.pickerBusinessType.toolbar
        pickerBusinessType.delegate = self
        pickerBusinessType.dataSource = self
        self.pickerBusinessType.toolbarDelegate = self
        self.pickerBusinessType.reloadAllComponents()
        
        txt_NumberOf.inputView = pickerEmpSize
        self.txt_NumberOf.inputAccessoryView = self.pickerEmpSize.toolbar
        pickerEmpSize.delegate = self
        pickerEmpSize.dataSource = self
        self.pickerEmpSize.toolbarDelegate = self
        self.pickerEmpSize.reloadAllComponents()
        
    }
    
    
    func GetAll(){
        BusinessTypeArray.removeAll()
        EmpSizeArray.removeAll()
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.PostWithBody(url: APIConstants.GetDropdowns, Tag: 1)
    }
    
    
    func SetupType()
    {
        
        txt_BusinessType.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named:"Ui_Arrow_Down")
        imageView.image = image
        imageView.contentMode = .scaleToFill
        txt_BusinessType.rightView = imageView
    }
    
    func SetupNumEmpalyee()
    {
        txt_NumberOf.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named:"Ui_Arrow_Down")
        imageView.image = image
        imageView.contentMode = .scaleToFill
        txt_NumberOf.rightView = imageView
    }
    
    @IBAction func Btn_Next(_ sender: Any) {
        if validation(){
            print(RegisterParameter)
            RegisterParameter["BusinessType"] = self.BusinessTypeID
            RegisterParameter["BusinessSize"] = self.EmpSizeID
            RegisterParameter["BusinessName"] = self.txt_BusinessName.text!
            Register()
        }
    }
    
    func Register() {
        print(RegisterParameter)
        let params = RegisterParameter
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.Register, method: .post, parameters: params, tag: 2, header: headers)
    }
}

extension BusinessInfoVC: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        
        self.view.endEditing(true)
    }
    
    func didTapCancel() {
        if  pickerslectnum == 1
        {
            self.txt_BusinessType.text = nil
            self.txt_BusinessType.resignFirstResponder()
        }else if pickerslectnum == 2{
            self.txt_NumberOf.text = nil
            self.txt_NumberOf.resignFirstResponder()
            
        }else
        {
            print("nil")
        }
        self.view.endEditing(true)
    }
}

extension BusinessInfoVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerBusinessType {
            return BusinessTypeArray.count+1
        }
          else {
            return EmpSizeArray.count+1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerBusinessType {
            if row == 0{
                return  AppCommon.sharedInstance.localization("selectBusinessType")
            }else {
                
                
                    return BusinessTypeArray[row-1].na
                
                
            }
        } else {
            if row == 0{
                return AppCommon.sharedInstance.localization("selectNumEmp")
            }else {
               
                    return EmpSizeArray[row-1].na
                
            }
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerBusinessType {
            pickerslectnum = 1
            if BusinessTypeArray.count != 0 {
                if row == 0 {
                    txt_BusinessType.text = nil
                    
                }else {
                    
                        txt_BusinessType.text = BusinessTypeArray[row-1].na
                    
                    BusinessTypeID = BusinessTypeArray[row-1].id
                    
                }
            }
            
        }
        else {
            pickerslectnum = 2
            if EmpSizeArray.count != 0 {
                if row == 0 {
                    txt_NumberOf.text = nil
                    
                }else {
                    txt_NumberOf.text = EmpSizeArray[row-1].na
                    
                    EmpSizeID = EmpSizeArray[row-1].id
                    
                }
            }
            
        }
        
        //        self.view.endEditing(true)
    }
    
    func validation () -> Bool {
        var isValid = true
        
        if EmpSizeID == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("selectNumEmp"))
            isValid = false
        }
        if BusinessTypeID == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("selectBusinessType"))
            isValid = false
        }
        
        if txt_BusinessName.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("selectBusinessname"))
            isValid = false
        }
        
        return isValid
    }
    
    
    
    
}


extension BusinessInfoVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
      let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        if Tag == 1 {
            let json = JSON(dictResponse)
            let data = JSON(json["Dropdowns"])
            let BusinessTypes =  JSON(data["BusinessTypes"])
            let BusinessSizes =  JSON(data["BusinessSizes"])
           
            print(BusinessSizes)
            print(BusinessTypes)
           
            BusinessTypeArray.removeAll()
              EmpSizeArray.removeAll()
            
                let result =  BusinessTypes.arrayValue
                for json in result{
                    let obj = DropdownModel(dbId: json["dbId"].stringValue, id: json["id"].stringValue, cid: json["cid"].stringValue, cnid: json["cnid"].stringValue, na: json["na"].stringValue)
                    BusinessTypeArray.append(obj)
                }
            
            let resultemp =  BusinessSizes.arrayValue
            for json in resultemp{
                let obj = DropdownModel(dbId: json["dbId"].stringValue, id: json["id"].stringValue, cid: json["cid"].stringValue, cnid: json["cnid"].stringValue, na: json["na"].stringValue)
                EmpSizeArray.append(obj)
            }
            
            
            } else {
                
                Loader.showError(message: (forbiddenMail))
            }
        if Tag == 2 {
           
            let json = JSON(dictResponse)
            let data = JSON(json["Result"])
              let State = JSON(json["State"])
            
            print(json)
             print(data)
            if State.stringValue == "100"
            {
            let Setting = UIStoryboard(name: "Auth", bundle: nil)
            let VerifyCodeVC = Setting.instantiateViewController(withIdentifier: "VerifyCodeVC") as! VerifyCodeVC
            VerifyCodeVC.mobile =  RegisterParameter["MobileNumber"] as! String
            VerifyCodeVC.UserId = data["UserId"].stringValue
            self.navigationController?.pushViewController(VerifyCodeVC, animated: true)
            }else{
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


