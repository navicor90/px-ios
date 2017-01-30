//
//  MercadoPagoContext.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 1/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import Foundation

public class MercadoPagoContext {

    static let sharedInstance = MercadoPagoContext()

    var public_key: String = ""

    var private_key: String = ""

    var base_url: String = ""

    var customer_uri: String = ""

    var merchant_access_token: String = ""

    //TODO : complete with default preference_uri
    var preference_uri: String = ""

    var payment_uri: String = ""

    public class var PUBLIC_KEY: String {
        return "public_key"
    }

    public class var PRIVATE_KEY: String {
        return "private_key"
    }

    public class func isAuthenticatedUser() -> Bool {
        return !sharedInstance.private_key.isEmpty
    }

    private init() {} //This prevents others from using the default '()' initializer for this class.

    public class func setPrivateKey(private_key: String) {

        sharedInstance.private_key = private_key

    }

    public class func setPublicKey(public_key: String) {

        sharedInstance.public_key = public_key

    }

    public class func setBaseURL(base_url: String) {

        sharedInstance.base_url = base_url

    }

    public class func setCustomerURI(customer_uri: String) {

        sharedInstance.customer_uri = customer_uri

    }

    public class func setPreferenceURI(preference_uri: String) {

        sharedInstance.preference_uri = preference_uri

    }

    public class func setMerchantAccessToken(merchant_access_token: String) {

        sharedInstance.merchant_access_token = merchant_access_token

    }

    public class func merchantAccessToken() -> String {

        return sharedInstance.merchant_access_token

    }

    public class func publicKey() -> String {

        return sharedInstance.public_key

    }

    public class func privateKey() -> String {

        return sharedInstance.private_key

    }

    public class func baseURL() -> String {

        return sharedInstance.base_url

    }
    public class func customerURI() -> String {

        return sharedInstance.customer_uri

    }

    public class func preferenceURI() -> String {

        return sharedInstance.preference_uri

    }

    public class func paymentURI() -> String {

        return sharedInstance.payment_uri

    }

    public class func keyType() -> String {
        if(MercadoPagoContext.isAuthenticatedUser()) {
            return MercadoPagoContext.PRIVATE_KEY
        } else {
            return MercadoPagoContext.PUBLIC_KEY
        }
    }

    public class func keyValue(forcingPublic: Bool = true) -> String {
        if forcingPublic {
            return MercadoPagoContext.publicKey()
        }
        if(MercadoPagoContext.isAuthenticatedUser()) {
            return MercadoPagoContext.privateKey()
        } else {
            return MercadoPagoContext.publicKey()
        }
    }

}
