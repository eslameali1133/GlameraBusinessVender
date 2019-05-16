//
//  APIConstants.swift
//  CarWash
//
//  Created by Mohammad Farhan on 22/12/1710/11/17.
//  Copyright © 2017 CarWash. All rights reserved.
//

import Foundation

open class APIConstants {
   static let SERVER_URL = "https://api.glamour-plan.com/api/"
//   static let SERVER_URL = "http://192.168.1.111:8080/cartime-1.1/cartime/api/"
    
   
     static let CheckEmail = SERVER_URL + "Account/CheckEmail"
     static let CheckUserName = SERVER_URL + "Account/CheckUserName"
     static let GetDropdowns = SERVER_URL + "SystemCodes/GetDropdowns"
     static let Register = SERVER_URL + "Account/Register"
      static let ResendVerifyPhoneCode = SERVER_URL + "Account/ResendVerifyPhoneCode"
     static let VerifyPhone = SERVER_URL + "Account/VerifyPhone"
     static let ForgetPassword = SERVER_URL + "Account/ForgetPassword"
     static let Login = "https://api.glamour-plan.com/token"
     static let EmployeeGet = SERVER_URL + "Employee/Get"
     static let EmployeeAdd = SERVER_URL + "Employee/Create"
       static let EmployeeEdit = SERVER_URL + "Employee/update"
 static let GetAccountInfo = SERVER_URL + "AccountSetup/GetAccountInfo"
     static let UpdateInfo = SERVER_URL + "AccountSetup/UpdateInfo"
    
    
}
