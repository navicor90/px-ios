//
//  ServicePreference.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 1/24/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import Foundation

open class ServicePreference : NSObject{
    
    var customerURL: String?
    var customerURI = ""
    var customerAdditionalInfo: NSDictionary?
    var checkoutPreferenceURL: String?
    var checkoutPreferenceURI = ""
    var checkoutAdditionalInfo: NSDictionary?
    var paymentURL: String = MP_API_BASE_URL
    var paymentURI: String = MP_PAYMENTS_URI + "?api_version=" + API_VERSION
    var paymentAdditionalInfo: NSDictionary?
    
    internal static let MP_ALPHA_ENV = "/gamma"
    internal static var MP_TEST_ENV = "/beta"
    internal static let MP_PROD_ENV = "/v1"
    internal static let API_VERSION = "1.3.X"
    
    internal static let MP_ENVIROMENT = MP_PROD_ENV  + "/checkout"
    
    internal static let MP_OP_ENVIROMENT = "/v1"
    
    internal static let MP_ALPHA_API_BASE_URL : String =  "http://api.mp.internal.ml.com"
    internal static let MP_API_BASE_URL_PROD : String =  "https://api.mercadopago.com"
    
    internal static let MP_API_BASE_URL : String =  MP_API_BASE_URL_PROD
    
    internal static let MP_CUSTOMER_URI = "/customers?preference_id="
    internal static let MP_PAYMENTS_URI = MP_ENVIROMENT + "/payments"
    
    private var useDefaultPaymentSettings = true
    
    var baseURL: String = MP_API_BASE_URL
    var gatewayURL: String?
    
    public func setGetCustomer(baseURL: String, URI: String , additionalInfo: [String:String] = [:]) {
        customerURL = baseURL
        customerURI = URI
        customerAdditionalInfo = additionalInfo as NSDictionary
    }
    
    public func setCreatePayment(baseURL: String = MP_API_BASE_URL, URI: String = MP_PAYMENTS_URI + "?api_version=" + API_VERSION, additionalInfo: NSDictionary = [:]) {
        paymentURL = baseURL
        paymentURI = URI
        paymentAdditionalInfo = additionalInfo
        self.useDefaultPaymentSettings = false
    }
    
    public func setCreateCheckoutPreference(baseURL: String, URI: String, additionalInfo: NSDictionary = [:]) {
        checkoutPreferenceURL = baseURL
        checkoutPreferenceURI = URI
        checkoutAdditionalInfo = additionalInfo
    }
    
    public func setAdditionalPaymentInfo(_ additionalInfo: NSDictionary){
        paymentAdditionalInfo = additionalInfo
    }
    
    public func setDefaultBaseURL(baseURL: String) {
        self.baseURL = baseURL
    }
    
    public func setGatewayURL(gatewayURL: String) {
        self.gatewayURL = gatewayURL
    }
    
    public func getDefaultBaseURL() -> String {
        return baseURL
    }
    
    public func getGatewayURL() -> String {
        return gatewayURL ?? baseURL
    }
    
    public func getCustomerURL() -> String? {
        return customerURL
    }
    
    public func getCustomerURI() -> String {
        return customerURI
    }
    
    public func isUsingDeafaultPaymentSettings() -> Bool {
        return useDefaultPaymentSettings
    }
    
    public func getCustomerAddionalInfo() -> String {
        if !NSDictionary.isNullOrEmpty(customerAdditionalInfo){
            return customerAdditionalInfo!.parseToQuery()
        }
        return ""
    }
    
    public func getPaymentURL() -> String {
        if paymentURL == ServicePreference.MP_API_BASE_URL && baseURL != ServicePreference.MP_API_BASE_URL {
            return baseURL
        }
        return paymentURL
    }
    
    public func getPaymentURI() -> String {
        return paymentURI
    }
    
    public func getPaymentAddionalInfo() -> String {
        if !NSDictionary.isNullOrEmpty(paymentAdditionalInfo){
            return paymentAdditionalInfo!.toJsonString()
        }
        return ""
    }
    
    public func getCheckoutPreferenceURL() -> String?{
        return checkoutPreferenceURL
    }
    
    public func getCheckoutPreferenceURI() -> String {
        return checkoutPreferenceURI
    }
    
    public func getCheckoutAddionalInfo() -> String {
        if !NSDictionary.isNullOrEmpty(checkoutAdditionalInfo){
            return checkoutAdditionalInfo!.toJsonString()
        }
        return ""
    }
    
    public func isGetCustomerSet() -> Bool {
        return !String.isNullOrEmpty(customerURL)
    }
    
    public func isCheckoutPreferenceSet() -> Bool {
        return !String.isNullOrEmpty(checkoutPreferenceURL)
    }
    
    public func isCreatePaymentSet() -> Bool {
        return !String.isNullOrEmpty(paymentURL)
    }
    
    public func isCustomerInfoAvailable() -> Bool {
        return !String.isNullOrEmpty(self.customerURL) && !String.isNullOrEmpty(self.customerURI) && customerAdditionalInfo != nil
    }

}
