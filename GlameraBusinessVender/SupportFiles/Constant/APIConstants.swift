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
    
    static let Register = SERVER_URL + "users/register"
    static let SendVeriCode = SERVER_URL + "users/GenerateVRFCode"
    static let Login = SERVER_URL + "users/login"
    static let changePassword = SERVER_URL + "users/changePassword"
     static let GetProviderBrand = SERVER_URL + "ProviderAccount/GetProviderCarBrands?"
     static let SaveProviderBrand = SERVER_URL + "ProviderAccount/SaveProviderBrands"
    static let CheckMobile = SERVER_URL + "Users/CheckMobile"
    static let GetVenderProfile = SERVER_URL + "ProviderAccount/GetProfile"
    static let GetCarOwnerProfile = SERVER_URL + "Customer/GetProfile"
    
     static let SaveVenderProfile = SERVER_URL + "ProviderAccount/SaveProfile"
      static let GetCountry = SERVER_URL + "Country/GetAllCountry"
      static let GetCity = SERVER_URL + "City/GetAllCity"
      static let GetArea = SERVER_URL + "Area/GetAllAreas"
     static let ContactUS = SERVER_URL + "ContactUs/SaveContactUs"
       static let LogOut = SERVER_URL + "users/Logout"
      static let GetServiceType = SERVER_URL + "ServiceType/GetAllServiceTypes"
        static let GetProviderServices = SERVER_URL + "ProviderAccount/GetProviderServices"

    static let SaveProviderService = SERVER_URL + "ProviderAccount/SaveServicesProvider"
    static let Order = SERVER_URL + "Order/GetOrders?"
     static let GetCustomerOrders = SERVER_URL + "Order/GetCustomerOrders?"
   
    static let AcceptOrder = SERVER_URL + "OrderStatus/AcceptOrder?"
    
    static let RejectOrder = SERVER_URL + "OrderStatus/RejectOrder?"
     static let RejectOrderCus = SERVER_URL + "OrderStatus/CancelOrder?"
    
    static let ServiceType = SERVER_URL + "ServiceType/GetAllServiceTypes"
    static let GetAllServices = SERVER_URL + "Services/GetAllServices?"
    static let GetOrderDetails = SERVER_URL + "Order/GetOrderDetails?"
    static let SaveDetailsInvoice = SERVER_URL + "Order/SaveDetailsInvoice"
    static let FinishedOrder = SERVER_URL + "OrderStatus/FinishedOrder?"
       static let ActiveProvder = SERVER_URL + "ProviderAccount/ActivateProvider?"
        static let GetReason = SERVER_URL + "Reasons/GetAllReasons"
  static let GetReasonCutomer = SERVER_URL + "Reasons/GetAllReasons?ProviderReasons=false"

   static let saveCusRate = SERVER_URL + "Customer/SaveRate"
     static let saveVenderRate = SERVER_URL + "ProviderAccount/SaveRate"
    
     static let SaveOrderService = SERVER_URL + "Order/SaveDetailsInvoiceOveride"
     static let OrderSaveDuration = SERVER_URL + "Order/SaveDuration"
       static let GetMyCar = SERVER_URL + "CustomerCars/GetMyCars"
      static let CarBrands = SERVER_URL + "CarBrands/GetAllCarBrands"
     static let CarModels = SERVER_URL + "CarModels/GetAllCarModels"
  static let GetMyCarDetails = SERVER_URL + "CustomerCars/GetCar?"
  static let CustomerDelteCars = SERVER_URL + "CustomerCars/DeleteItem"
  static let GetServiceTypes = SERVER_URL + "ServiceType/GetServiceTypes"
    
  static let SearchProvider = SERVER_URL + "ProviderAccount/SearchProvider"
  static let SearchProviderLocation = SERVER_URL + "ProviderAccount/SearchProviderLocation"
    
  static let GetProvderDetails = SERVER_URL + "ProviderAccount/GetProviderProfile?"
 
     static let GetOrderType = SERVER_URL + "OrderType/OrderTypeList"
    
    static let token = "3GgcQ0a_6bFU2Jkm8h301Olx-vCgnajKrOviwpWqAzhrp41q9sJotVVhQPmFWJ9BtF9gRW2mzfocSZ-LWEBO_7KogpDVZHlons4VcAx3jZeHbVhndYJ29mUw2SqCfuDLWeTe0pfoGtPO-hseQj-tQGxO7SInVxH97yZzUX9xged-r-FVQkqSYg7RbzbBFclEdjpzmkAUv062YL-vNkn6o6hWlKSh4uHVFHdHgziKJ0hQVDFLcPDYtHjyQqe0wlpIeGTYgSGT1ATjWQUJ-doCdJ_r5VbGmQHhHrPWWuej2aL6B3xopGhXQuCKJKIZ9jjsEFN2muIAnQtIJrCXhCr6QNY58JnTeAqBW6bgjaptnoaFTSuIkH4qj7HyGBKcSes0nudxm4JZTgRV8TXrMkLtoSg2oCWDCZf6k0uwG4K9ygIme4amo5QdupgZ-CaVQc52coI3yOzAFHKYQeMXia-SafBlzBIbjFqiaYnzkRXitjIhYiiM"
   
    

}
