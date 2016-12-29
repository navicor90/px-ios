//
//  DiscountCoupon.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 12/26/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

open class DiscountCoupon: NSObject {

    
    /*
     
     {
     "id": 12572,
     "name": "testChoOFF",
     "percent_off": 10,
     "amount_off": 0,
     "coupon_amount": 11,
     "currency_id": "ARS"
     }
     
     {
     "id": 15098,
     "name": "TestChoNativo2 (236387490)",
     "percent_off": 0,
     "amount_off": 15,
     "coupon_amount": 15,
     "currency_id": "ARS"
     }
     
     
     */
    
    var _id : String!
    var name : String!
    var percent_off : String!
    var amount_off : String!
    var coupon_amount : String!
    var currency_id : String!
    
    /*
    public init(id : String, name : String, percent_off : String, amount_off : String, coupon_amount : String, currency_id : String) {
        
        self._id = id
        self.name = name
        self.percent_off = percent_off
        self.amount_off = amount_off
        self.coupon_amount = coupon_amount
        self.currency_id = currency_id
        
    }
    */
    
    open class func fromJSON(_ json : NSDictionary) -> DiscountCoupon? {
        let discount = DiscountCoupon()
        if json["id"] != nil && !(json["id"]! is NSNull) {
            discount._id = String( describing: json["id"] as! NSNumber)
        }else{
            return nil
        }
        if json["name"] != nil && !(json["name"]! is NSNull) {
            discount.name = json["name"] as! String
        }
        if json["percent_off"] != nil && !(json["percent_off"]! is NSNull) {
            discount.percent_off = String( describing: json["percent_off"]  as! NSNumber)
        }
        if json["amount_off"] != nil && !(json["amount_off"]! is NSNull) {
            discount.amount_off = String( describing: json["amount_off"]  as! NSNumber)
        }
        if json["coupon_amount"] != nil && !(json["coupon_amount"]! is NSNull) {
            discount.coupon_amount = String( describing: json["coupon_amount"]  as! NSNumber)
        }
        if json["currency_id"] != nil && !(json["currency_id"]! is NSNull) {
            discount.currency_id = json["currency_id"] as! String
        }
        return discount
    }
}
