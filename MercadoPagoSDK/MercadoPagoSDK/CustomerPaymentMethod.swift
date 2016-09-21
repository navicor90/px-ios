//
//  CustomerPaymentMethod.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 4/8/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class CustomerPaymentMethod: NSObject, CustomerInformation {
    
    var _id : String!
    var _description : String!
    var type : String!
    var paymentMethodId : String!
    private var paymentMethod : PaymentMethod?
    
    var securityCode : SecurityCode = SecurityCode()
    
    public class func fromJSON(json : NSDictionary) -> CustomerPaymentMethod {
        let customerPaymentMethod = CustomerPaymentMethod()
        
        if json["id"] != nil && !(json["id"]! is NSNull) {
            customerPaymentMethod._id = json["id"] as! String
        }

        if json["description"] != nil && !(json["description"]! is NSNull) {
            customerPaymentMethod._description = json["description"] as! String
        }
        
        if json["payment_method_id"] != nil && !(json["payment_method_id"]! is NSNull) {
            customerPaymentMethod.paymentMethodId = json["payment_method_id"] as! String
        }
        
        if json["type"] != nil && !(json["type"]! is NSNull) {
            customerPaymentMethod.type = json["type"] as! String
        }
        
        return customerPaymentMethod
    }
    
    
    public func toJSON() -> JSON {
        let obj:[String:AnyObject] = [
            "_id": self._id,
            "_description": self._description == nil ? "" : self._description!,
            "type" : self.type,
            "payment_method_id": self.paymentMethodId
        ]
        
        return JSON(obj)
    }
    
    public func toJSONString() -> String {
        return self.toJSON().toString()
    }

    public func isSecurityCodeRequired() -> Bool {
        return true;
    }
    
    public func getId() -> String {
        return self._id
    }
    
    public func getCardSecurityCode() -> SecurityCode {
        return self.securityCode
    }
    
    public func getDescription() -> String {
        return self._description
    }
    
    public func getPaymentTypeId() -> String {
        return self.type
    }
    
    public func getPaymentMethod() -> PaymentMethod {
        if self.paymentMethod != nil {
            return paymentMethod!
        }
        
        let pm = PaymentMethod()
        pm._id = self.paymentMethodId
        return pm
    }
    
    public func getPaymentMethodId() -> String {
        return self.paymentMethodId
    }
    
    public func setupPaymentMethod(paymentMethod : PaymentMethod) {
        self.paymentMethod = paymentMethod
    }
    
    public func getLastFourDigits() -> String {
        return ""
    }
    
}
