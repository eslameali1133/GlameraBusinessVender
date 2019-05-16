//
//  MoreCarOwnerVC.swift
//  MAAKMAAK
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON

class MoreVC: UIViewController {
    
    var items = [String]()
    var images = [String]()
    @IBOutlet weak var tblMoe: UITableView!
    //    @IBOutlet weak var lblItemName: UILabel!
    var MyService :String = AppCommon.sharedInstance.localization("MyService")
     var MyEmployee :String = AppCommon.sharedInstance.localization("myemployee")
    var AccountSeeting :String = AppCommon.sharedInstance.localization("Account Setting")
    var BusinessInfo = AppCommon.sharedInstance.localization("BusinessInfo")
  let changeLanguagestr = AppCommon.sharedInstance.localization("changeLanguage")
    var Logout = AppCommon.sharedInstance.localization("Logout")
    
    
    
    var http = HttpHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        getData()
        tblMoe.changeView()
    }
    func getData()  {
        
      
            items = [MyService,MyEmployee,AccountSeeting,BusinessInfo,Logout,changeLanguagestr]
        images = ["Briefcase_-_simple-line-icons","User_-_simple-line-icons","Settings_-_simple-line-icons","Bulb_-_simple-line-icons","path_2","path_2"]
        
    }
    
    func logout(){

        // move to login
        /// move home
        let sb = UIStoryboard(name: "Auth", bundle: nil)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = sb.instantiateInitialViewController()
         SharedData.SharedInstans.SetIsLogin(false)
    }
    
    func ShareApp()
    {
        let myWebsite = NSURL(string:"http://www.google.com/")
        guard let url = myWebsite else {
            print("nothing found")
            return
        }
        let shareItems:Array = [url]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    func changeLanguage() {
        AppCommon.sharedInstance.alertWith(title: AppCommon.sharedInstance.localization("changeLanguage"), message: AppCommon.sharedInstance.localization("changeLanguageMessage"), controller: self, actionTitle: AppCommon.sharedInstance.localization("change"), actionStyle: .default, withCancelAction: true) {
            
            if  SharedData.SharedInstans.getLanguage() == "en" {
                L102Language.setAppleLAnguageTo(lang: "ar")
                SharedData.SharedInstans.setLanguage("ar")
                
            } else if SharedData.SharedInstans.getLanguage() == "ar" {
                L102Language.setAppleLAnguageTo(lang: "en")
                SharedData.SharedInstans.setLanguage("en")
                
            }
            UIView.appearance().semanticContentAttribute = SharedData.SharedInstans.getLanguage() == "en" ? .forceLeftToRight : .forceRightToLeft
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            //  let storyboard = UIStoryboard(name: "StoryBord", bundle: nil)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil);
            
            
            delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            
        }
        
    }
    
    
}

extension MoreVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath) as! MoreCell
        cell.lblItemName.text = items[indexPath.row]
        cell.IconImage.image =  UIImage(named: images[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            switch indexPath.row {
            case 0:
                //  my MyService
               print(123)
            case 1:
                 //  my Employes
                let Setting = UIStoryboard(name: "employee", bundle: nil)
                let EmployeeVC = Setting.instantiateViewController(withIdentifier: "EmployeeVC") as! EmployeeVC
              
                self.navigationController?.pushViewController(EmployeeVC, animated: true)
            case 2:
                    //  my QuickRequest
                let Setting = UIStoryboard(name: "AccountSetting", bundle: nil)
                let AccountSettingVC = Setting.instantiateViewController(withIdentifier: "AccountSettingVC") as! AccountSettingVC
                
                self.navigationController?.pushViewController(AccountSettingVC, animated: true)

                
            case 3:
               print(123)
            case 4:
                logout()
                case 5:
            changeLanguage()
            default:
                break
            }
    }
            
        
}


extension MoreVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        
        let json = JSON(dictResponse)
        
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Error")
        if Tag == 1 {
            
            let status =  json["status"]
            
            print(status)
            print(json["status"])
            if status.stringValue  == "201" {
               
                SharedData.SharedInstans.SetIsLogin(false)
                _ = UserDefaults.standard.removeObject(forKey: "UserId")
                
                tblMoe.reloadData()
                AppCommon.sharedInstance.ShowHome()
                
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


// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"
/// L102Language
class L102Language {
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}
