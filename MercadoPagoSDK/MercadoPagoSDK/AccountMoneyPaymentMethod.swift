//
//  AccountMoneyPaymentMethod.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 9/15/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class AccountMoneyPaymentMethod: NSObject {

    var dateDue : NSDate?
    var status : String?
    var amount : Double?
   
    public override init(){
        super.init()
    }
    
    public class func fromJSON(json : NSDictionary) -> AccountMoneyPaymentMethod {
        let accountMoneyPM = AccountMoneyPaymentMethod()
        
        if json["date_due"] != nil && !(json["date_due"]! is NSNull) {
            accountMoneyPM.dateDue = Utils.getDateFromString(json["date_due"] as? String)
        }
        
        if json["status"] != nil && !(json["status"]! is NSNull) {
            accountMoneyPM.status = json["status"]!.stringValue
        }

        if json["amount"] != nil && !(json["amount"]! is NSNull) {
            accountMoneyPM.amount = json["amount"]!.doubleValue
        }
        
        return accountMoneyPM
    }
}
