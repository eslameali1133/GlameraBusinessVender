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

//   static let SERVER_URL = "https://api.glamour-plan.com/api"
    static let GetOrders = SERVER_URL + "Booking/GetDynamic"
    static let BookingStatus = SERVER_URL + "Booking/UpdateBookingStatus"

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
    
    

  static let GetProvderDetails = SERVER_URL + "ProviderAccount/GetProviderProfile?"
 
     static let GetOrderType = SERVER_URL + "OrderType/OrderTypeList"
    
    static let token = "3GgcQ0a_6bFU2Jkm8h301Olx-vCgnajKrOviwpWqAzhrp41q9sJotVVhQPmFWJ9BtF9gRW2mzfocSZ-LWEBO_7KogpDVZHlons4VcAx3jZeHbVhndYJ29mUw2SqCfuDLWeTe0pfoGtPO-hseQj-tQGxO7SInVxH97yZzUX9xged-r-FVQkqSYg7RbzbBFclEdjpzmkAUv062YL-vNkn6o6hWlKSh4uHVFHdHgziKJ0hQVDFLcPDYtHjyQqe0wlpIeGTYgSGT1ATjWQUJ-doCdJ_r5VbGmQHhHrPWWuej2aL6B3xopGhXQuCKJKIZ9jjsEFN2muIAnQtIJrCXhCr6QNY58JnTeAqBW6bgjaptnoaFTSuIkH4qj7HyGBKcSes0nudxm4JZTgRV8TXrMkLtoSg2oCWDCZf6k0uwG4K9ygIme4amo5QdupgZ-CaVQc52coI3yOzAFHKYQeMXia-SafBlzBIbjFqiaYnzkRXitjIhYiiM"
   
    


}
