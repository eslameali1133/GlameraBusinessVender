//
//  AppCommon.swift
//  AshakAlena
//
//  Created by Mohammad Farhan on 22/12/176/8/17.
//  Copyright © 2017 Mohammad Farhan. All rights reserved.
//

import Foundation
import UIKit
//import JBWebViewController
//import SwiftyJSON


class AppCommon: UIViewController {
    
    static let sharedInstance = AppCommon()

    func dismissLoader(_ view:UIView){
        view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    
    func roundingUIView( _ aView: UIView!,  cornerRadiusParam: CGFloat!) {
        aView.layer.cornerRadius = cornerRadiusParam
        aView.clipsToBounds = true
    }
    
//    func showWithReveal(vc: UIViewController, storyBoardName: String, controllerName: String) {
//        let sb = UIStoryboard(name: storyBoardName, bundle: nil)
//        let controller = sb.instantiateViewController(withIdentifier: controllerName)
//        vc.revealViewController().setFront(controller, animated: true)
//    }
//    
//    func showWithRevealToggle(vc: UIViewController, storyBoardName: String, controllerName: String) {
//        let sb = UIStoryboard(name: storyBoardName, bundle: nil)
//        let controller = sb.instantiateViewController(withIdentifier: controllerName)
//        vc.revealViewController().setFront(controller, animated: true)
//        
//        if SharedData.SharedInstans.getLanguage() == "ar" && L102Language.currentAppleLanguage() == "ar" {
//                    vc.revealViewController().rightRevealToggle(animated: true)
//        } else {
//            vc.revealViewController().revealToggle(animated: true)
//        }
//        
//    }

    
    
    func GotoVerificationcode(vc: UIViewController,UserID: String,userType:Bool,Mobile:String) {
//        let sb = UIStoryboard(name: "Authstory", bundle: nil)
//        let controller = sb.instantiateViewController(withIdentifier: "VerifyCodeVC") as! VerifyCodeVC
//
//        controller.UserID = UserID
//        controller.UserType = userType
//        controller.mobile = Mobile
//        controller.FalgComeFromRegister = true
//        vc.navigationController?.pushViewController(controller, animated: true)
    }
    func ShowHome() {
        
       
      let UserType = UserDefaults.standard.string(forKey: "UserType")!
        print(UserType)
        if UserType == "true"
        {
            let sb = UIStoryboard(name: "CarOwner", bundle: nil)
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.window?.rootViewController = sb.instantiateInitialViewController()
            
        }else{
            
            let sb = UIStoryboard(name: "HomeVender", bundle: nil)
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.window?.rootViewController = sb.instantiateInitialViewController()
        }
        
    }
    
    func ShowHomeCarowner() {
        let sb = UIStoryboard(name: "CarOwner", bundle: nil)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = sb.instantiateInitialViewController()
    }
    
    func showlogin(vc: UIViewController) {
        
//        let sb = UIStoryboard(name: "Authstory", bundle: nil)
//        let controller = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        
//        vc.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
//
//    func showLogin(vc: UIViewController) {
//        let sb = UIStoryboard(name: "Login", bundle: nil)
//        let controller = sb.instantiateViewController(withIdentifier: "Login")
//        vc.revealViewController().setFront(controller, animated: true)
//    }

    
//    func OpenUrl(_ URL:String){
//        let controller = JBWebViewController(url: Foundation.URL(string: URL))
//        if let topController = UIApplication.topViewController() {
//            controller?.show(from: topController)
//        }
//    }
    
    
    func alert(title: String, message: String, controller: UIViewController, actionTitle: String, actionStyle: UIAlertAction.Style) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: actionStyle, handler: nil))
        alert.view.tintColor = UIColor.hexColor(string: "023f82")

        controller.present(alert, animated: true, completion: nil)

    }
    
    
    func alertWith(title: String, message: String, controller: UIViewController, actionTitle: String, actionStyle: UIAlertAction.Style, withCancelAction: Bool, completion: @escaping () -> Void) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: actionStyle, handler: { (action) in
            completion()
        }))
        alert.view.tintColor = UIColor.hexColor(string: "023f82")
        if withCancelAction {
        alert.addAction(UIAlertAction(title: AppCommon.sharedInstance.localization("cancel"), style: .cancel, handler: nil))
        }
        
        controller.present(alert, animated: true, completion: nil)
    }

    

    
    func NotFound(_ view:UITableView! , Msg:String? , Count:Int){
        if(Count <= 0){
            let  notFound: UILabel = UILabel()
            notFound.text = Msg
            notFound.font = UIFont(name: "HacenTunisiaBd", size: 12)
            notFound.numberOfLines = 2
            notFound.textAlignment = NSTextAlignment.center
            view.backgroundView = notFound
            view.separatorStyle=UITableViewCell.SeparatorStyle.none
            
        }else{
            let  notFound: UILabel = UILabel()
            notFound.text = ""
            notFound.textAlignment = NSTextAlignment.center
            view.backgroundView = notFound
            view.separatorStyle=UITableViewCell.SeparatorStyle.none
        }
        
    }
    
    func textInView(_ view:UIView! , Msg:String?,size: CGFloat,txtColor: UIColor){
        let  notFound: UILabel = UILabel()
        notFound.text = Msg
        notFound.font = UIFont(name: "HacenTunisiaBd", size: size)
        notFound.textColor = txtColor
        notFound.textAlignment = NSTextAlignment.center
        notFound.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(notFound)
    }
    
    
    func Alert(_ Message:String?,Title:String?,BtnOk:String?,Context:AnyObject ,Actions:@escaping ()->Void?){
        let WrongAlert=UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        WrongAlert.addAction(UIAlertAction(title: BtnOk, style: UIAlertAction.Style.default, handler: { Action in
            Actions()
        }))
        Context.present(WrongAlert, animated: true, completion: nil)
    }
    
    func ShowLoader(_ view:UIView,color:UIColor){
        let Loader  = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        Loader.backgroundColor = color
        Loader.tag = 1000
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        loadingIndicator.center = Loader.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        loadingIndicator.color = UIColor.black
        loadingIndicator.startAnimating();
        Loader.addSubview(loadingIndicator)
        view.addSubview(Loader)
    }
    
    
    
    
    func localization(_ key:String)->String {
        let lang = SharedData.SharedInstans.getLanguage()
        
        if let path = Bundle.main.path(forResource: "lang-\(lang)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                //                let jsonObj = JSON(data: data)
                let jsonDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                //                print(jsonDic!["couponNumber"]!)
                //                print("jsonData:\(jsonDic!)")
                if jsonDic![key] != nil {
                    return jsonDic![key] as! String
                }
                if !(jsonDic?.isEmpty)! {
                    //                    print("jsonData:\(jsonObj)")
                    return "_"+key
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                    return "_"+key
                    
                }
            } catch let error {
                print(error.localizedDescription)
                return "_"+key
                
            }
        } else {
            print("Invalid filename/path.")
            return "_"+key
            
        }
        
    }
    
}

