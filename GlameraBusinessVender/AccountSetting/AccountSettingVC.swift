//
//  AccountSettingVC.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/14/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftyJSON

class AccountSettingVC: UIViewController {
    @IBOutlet weak var txt_BusinessName: HoshiTextField!
    @IBOutlet weak var txt_BusinessType: HoshiTextField!
    @IBOutlet weak var txt_NumberOf: HoshiTextField!
    @IBOutlet weak var txt_Country: HoshiTextField!
    @IBOutlet weak var txt_City: HoshiTextField!
    @IBOutlet weak var txt_Area: HoshiTextField!
    @IBOutlet weak var txt_Address: HoshiTextField!
    @IBOutlet weak var txt_Phone: HoshiTextField!
    @IBOutlet weak var phoneKey: UITextField!
    @IBOutlet weak var lbl_phoneKey: UILabel!
    @IBOutlet weak var SaveBtn: UIButton!{
        didSet
        {
        self.SaveBtn.layer.cornerRadius = 12
            self.SaveBtn.layer.masksToBounds = true
        }
    }
   
    @IBOutlet weak var EditBtn: UIButton!{
        didSet
        {
            self.EditBtn.layer.cornerRadius = 9
            self.EditBtn.layer.masksToBounds = true
        }
    }
    let pickerBusinessType = ToolbarPickerView()
    let pickerEmpSize = ToolbarPickerView()
    let pickerCountry = ToolbarPickerView()
    let pickerCity = ToolbarPickerView()
     let pickerArea = ToolbarPickerView()
    let pickerPhoneKey = ToolbarPickerView()
    
    var BusinessTypeArray: [DropdownModel] = [DropdownModel]()
    var EmpSizeArray: [DropdownModel] = [DropdownModel]()
    var CountryArray: [DropdownModel] = [DropdownModel]()
    var CityArray: [DropdownModel] = [DropdownModel]()
     var AreaArray: [DropdownModel] = [DropdownModel]()
    var PhoneKeyArray: [String] = ["+20","+966"]
    
    var pickerslectnum = 0 // flage to different betwwen Deopdown
    var BusinessTypeID = ""
    var EmpSizeID = ""
    var CountryID = ""
    var CityID = ""
     var AreaID = ""
    var phonekeyid = "+20"
    var AcountModelData:AcountModel?
      var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        SaveBtn.isHidden = true
        SetupType()
        SetupEMpNumber()
        Setupcountry()
        SetupArea()
        Setupcity()
        SetUpPicker()
        http.delegate = self
        GetAll()
        getData()
        // Do any additional setup after loading the view.
    }
    
    func getData()  {
       
        let Acoumdid =  AppCommon.sharedInstance.getJSON("Profiledata")["AccountSetupId"].stringValue
        let token_type = AppCommon.sharedInstance.getJSON("Profiledata")["token_type"].stringValue
        let AccessToken = AppCommon.sharedInstance.getJSON("Profiledata")["access_token"].stringValue
        let params = ["Id":Acoumdid ] as [String: Any]
        let headers = ["Content-Type": "application/json","Authorization" : "\(token_type) \(AccessToken)"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.GetAccountInfo, method: .post, parameters: params, tag: 2, header: headers)
    }
    
    func SaveData()  {
       
        let params =  [ "Address":txt_Address.text!, "AreaId": AreaID, "BusinessSize": EmpSizeID, "BusinessType": BusinessTypeID, "CityId": CityID, "CountryId": CountryID, "Id": AcountModelData!.Id, "MobileNumber": txt_Phone.text!, "CompanyName": txt_BusinessName.text! ] as [String: Any]
        
        print(params)
        let headers = ["Content-Type": "application/json"]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.requestWithBody(url: APIConstants.UpdateInfo, method: .post, parameters: params, tag: 3, header: headers)
    }
    
    @IBAction func EditBtn(_ sender: Any) {
         SaveBtn.isHidden = false
    }
    
    @IBAction func Btn_Save(_ sender: Any) {
        if validation(){
            SaveData()
        }
    }
    
    func SetData(){
        
        if  AcountModelData?.CountryId != ""
        {
            CountryID = AcountModelData!.CountryId
             txt_Country.text = CountryArray.first{$0.dbId == AcountModelData?.CountryId}?.na
        }
       
        if  AcountModelData?.CityId != ""
        {
            CityID = AcountModelData!.CityId
            txt_City.text = CityArray.first{$0.dbId == AcountModelData?.CityId}?.na
        }
        
        if AcountModelData?.AreaId != ""
        {
            AreaID = AcountModelData!.AreaId
            txt_Area.text = AreaArray.first{$0.dbId == AcountModelData?.AreaId}?.na
        }
       
        if AcountModelData?.BusinessType != "null" || AcountModelData?.BusinessType != ""
        {
            BusinessTypeID = AcountModelData!.BusinessType
            txt_BusinessType.text = BusinessTypeArray.first{$0.id == AcountModelData?.BusinessType}?.na
        }
        if AcountModelData?.BusinessSize != "null" || AcountModelData?.BusinessSize != ""
        {
            EmpSizeID = AcountModelData!.BusinessSize
            txt_NumberOf.text = EmpSizeArray.first{$0.id == AcountModelData?.BusinessSize}?.na
        }
        
        if AcountModelData?.Address != "null" || AcountModelData?.Address != ""
        {
            txt_Address.text =  AcountModelData?.Address
        }
      
        if AcountModelData?.CompanyName != "null" || AcountModelData?.CompanyName != ""
        {
            txt_BusinessName.text =  AcountModelData?.CompanyName
        }
        
        if AcountModelData?.MobileNumber != "null" || AcountModelData?.MobileNumber != ""
        {
            txt_Phone.text =  AcountModelData?.MobileNumber
        }
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
        
        
        txt_Country.inputView = pickerCountry
        self.txt_Country.inputAccessoryView = self.pickerCountry.toolbar
        pickerCountry.delegate = self
        pickerCountry.dataSource = self
        self.pickerCountry.toolbarDelegate = self
        self.pickerCountry.reloadAllComponents()
        
        txt_City.inputView = pickerCity
        self.txt_City.inputAccessoryView = self.pickerCity.toolbar
        pickerCity.delegate = self
        pickerCity.dataSource = self
        self.pickerCity.toolbarDelegate = self
        self.pickerCity.reloadAllComponents()
        
        txt_Area.inputView = pickerArea
        self.txt_Area.inputAccessoryView = self.pickerArea.toolbar
        pickerArea.delegate = self
        pickerArea.dataSource = self
        self.pickerArea.toolbarDelegate = self
        self.pickerArea.reloadAllComponents()
        
        phoneKey.inputView = pickerPhoneKey
        self.phoneKey.inputAccessoryView = self.pickerPhoneKey.toolbar
        pickerPhoneKey.delegate = self
        pickerPhoneKey.dataSource = self
        self.pickerPhoneKey.toolbarDelegate = self
        self.pickerPhoneKey.reloadAllComponents()
    }
    
    
    func GetAll(){
        BusinessTypeArray.removeAll()
        EmpSizeArray.removeAll()
        CountryArray.removeAll()
        CityArray.removeAll()
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.PostWithBody(url: APIConstants.GetDropdowns, Tag: 1)
    }
    
    
    func SetupType()
    {
        
        txt_BusinessType.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named:"down-arrow (1)")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        txt_BusinessType.rightView = imageView
        
        
    }
    func SetupEMpNumber()
    {
        
        txt_NumberOf.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named:"down-arrow (1)")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        txt_NumberOf.rightView = imageView
        
        
    }
    
    func Setupcountry()
    {
        
        txt_Country.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named:"down-arrow (1)")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        txt_Country.rightView = imageView
        
        
    }
    
    func Setupcity()
    {
        
        txt_City.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named:"down-arrow (1)")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        txt_City.rightView = imageView
        
        
    }
    func SetupArea()
    {
        
        txt_Area.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named:"down-arrow (1)")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        txt_Area.rightView = imageView
        
        
    }
}



extension AccountSettingVC: ToolbarPickerViewDelegate {
    
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
            
        }
        else if pickerslectnum == 3{
            self.txt_Country.text = nil
            self.txt_Country.resignFirstResponder()
            
        }
        else if pickerslectnum == 4{
            self.txt_City.text = nil
            self.txt_City.resignFirstResponder()
            
        }
        else if pickerslectnum == 5{
            self.phoneKey.text = nil
            self.phoneKey.resignFirstResponder()
            
        }
        else if pickerslectnum == 6 {
            self.txt_Area.text = nil
            self.txt_Area.resignFirstResponder()
            
        }
       
        else
        {
            print("nil")
        }
        self.view.endEditing(true)
    }
}

extension AccountSettingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerBusinessType {
            return BusinessTypeArray.count+1
        }
        else if pickerView == pickerEmpSize {
            return EmpSizeArray.count+1
        }
        
        else if pickerView == pickerCountry {
            return CountryArray.count+1
        }
        else if pickerView == pickerCity {
            return CityArray.count+1
        }
        else if pickerView == pickerArea {
            return AreaArray.count+1
        }
        else {
             return PhoneKeyArray.count+1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerBusinessType {
            if row == 0{
                return  AppCommon.sharedInstance.localization("selectBusinessType")
            }else {
                
                return BusinessTypeArray[row-1].na
                
            }
        } else if pickerView == pickerEmpSize {
            if row == 0{
                return AppCommon.sharedInstance.localization("selectNumEmp")
            }else {
                
                return EmpSizeArray[row-1].na
                
            }
        }
        
        
        else if pickerView == pickerCountry {
            if row == 0{
                return AppCommon.sharedInstance.localization("Chosecountry")
            }else {
                
                return CountryArray[row-1].na
                
            }
        }
        else if pickerView == pickerCity {
            if row == 0{
                return AppCommon.sharedInstance.localization("ChoseCity")
            }else {
                
                return CityArray[row-1].na
                
            }
        }
        else if pickerView == pickerArea {
            if row == 0{
                return AppCommon.sharedInstance.localization("ChoseArea")
            }else {
                
                return AreaArray[row-1].na
                
            }
        }
        else  if row == 0{
            return AppCommon.sharedInstance.localization("SelectConuntrykey")
            
        }else {
            return PhoneKeyArray[row-1]
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
        else if pickerView == pickerEmpSize {
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
        
        
        else if pickerView == pickerCountry {
            pickerslectnum = 3
            if CountryArray.count != 0 {
                if row == 0 {
                    txt_Country.text = nil
                    
                }else {
                    txt_Country.text = CountryArray[row-1].na
                    
                    CountryID = CountryArray[row-1].dbId
                    
                }
            }
            
        }
        
        else if pickerView == pickerCity {
            pickerslectnum = 4
            if CityArray.count != 0 {
                if row == 0 {
                    txt_City.text = nil
                    
                }else {
                    txt_City.text = CityArray[row-1].na
                    
                    CityID = CityArray[row-1].dbId
                    
                }
            }
            
        }
        
        else if pickerView == pickerArea {
            pickerslectnum = 6
            if AreaArray.count != 0 {
                if row == 0 {
                    txt_Area.text = nil
                    
                }else {
                    txt_Area.text = AreaArray[row-1].na
                    
                    AreaID = AreaArray[row-1].dbId
                    
                }
            }
            
        }
        else  if PhoneKeyArray.count != 0 {
             pickerslectnum = 5
            if row == 0 {
                phoneKey.text = nil
                
            }else {
                lbl_phoneKey.text = PhoneKeyArray[row-1]
                phoneKey.text = ""
                phonekeyid = PhoneKeyArray[row-1]
                
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
        
        if CountryID == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("Chosecountry"))
            isValid = false
        }
        if CityID == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("ChoseCity"))
            isValid = false
        }
        
        
        if AreaID == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("ChoseArea"))
            isValid = false
        }
        
        return isValid
    }
    
    
    
    
}


extension AccountSettingVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        if Tag == 1 {
            let json = JSON(dictResponse)
            let data = JSON(json["Dropdowns"])
            let BusinessTypes =  JSON(data["BusinessTypes"])
            let BusinessSizes =  JSON(data["BusinessSizes"])
          
            let Countrys =  JSON(data["Countries"])
            let Citys =  JSON(data["Cities"])
              let Areas =  JSON(data["Areas"])
            print(BusinessSizes)
            print(BusinessTypes)
            
            BusinessTypeArray.removeAll()
            EmpSizeArray.removeAll()
           
            CountryArray.removeAll()
            CityArray.removeAll()
            
            AreaArray.removeAll()
            
            let resultAreas =  Areas.arrayValue
            for json in resultAreas{
                let obj = DropdownModel(dbId: json["dbId"].stringValue, id: json["id"].stringValue, cid: json["cid"].stringValue, cnid: json["cnid"].stringValue, na: json["na"].stringValue)
                AreaArray.append(obj)
            }
            
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
            
            
            let resultCountryArray =  Countrys.arrayValue
            for json in resultCountryArray{
                let obj = DropdownModel(dbId: json["dbId"].stringValue, id: json["id"].stringValue, cid: json["cid"].stringValue, cnid: json["cnid"].stringValue, na: json["na"].stringValue)
                CountryArray.append(obj)
            }
            
            let resulCitys =  Citys.arrayValue
            for json in resulCitys{
                let obj = DropdownModel(dbId: json["dbId"].stringValue, id: json["id"].stringValue, cid: json["cid"].stringValue, cnid: json["cnid"].stringValue, na: json["na"].stringValue)
                CityArray.append(obj)
            }
            
             SetData()
            
        } 
        if Tag == 2 {
            
            let json = JSON(dictResponse)
            let data = JSON(json["Result"])
            let State = JSON(json["State"])
            
            print(json)
            print(data)
            if State.stringValue == "100"
            {
                print(data)
                AcountModelData = AcountModel(Id: data["Id"].stringValue, CountryId:  data["CountryId"].stringValue, AreaId:  data["AreaId"].stringValue, MobileNumber:  data["MobileNumber"].stringValue, BusinessSize:  data["BusinessSize"].stringValue, CityId:  data["CityId"].stringValue, BusinessType:  data["BusinessType"].stringValue, Address:  data["Address"].stringValue, CompanyName:  data["CompanyName"].stringValue)
                SetData()
            }else{
                Loader.showError(message: (forbiddenMail))
            }
        }
        
        if Tag == 3{
             let json = JSON(dictResponse)
            let status = JSON(json["State"])
            print(json["status"])
            if status.stringValue  == "100" {
                Loader.showError(message: (AppCommon.sharedInstance.localization("done")))
                self.viewDidLoad()
                navigationController?.popViewController(animated: true)
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


