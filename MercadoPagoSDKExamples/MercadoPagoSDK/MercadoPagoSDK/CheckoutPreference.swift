//
//  CheckoutPreference.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 12/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class CheckoutPreference: NSObject {

    public var _id: String!
    public var items: [Item]?
    public var payer: Payer?
    public var paymentMethods: PreferencePaymentMethods?
    //shipments

    public init(items: [Item], payer: Payer, paymentMethods: PreferencePaymentMethods?) {
        super.init()
        self.items = items
        self.payer = payer
        self.paymentMethods = paymentMethods
    }

    public override init() {
        super.init()
    }

    public class func fromJSON(json: NSDictionary) -> CheckoutPreference {
        let preference: CheckoutPreference = CheckoutPreference()

        if json["id"] != nil && !(json["id"]! is NSNull) {
            preference._id = (json["id"]! as? String)
        }

        if json["payer"] != nil && !(json["payer"]! is NSNull) {
            preference.payer = Payer.fromJSON(json["payer"]! as! NSDictionary)
        }

        var items = [Item]()
        if let itemsArray = json["items"] as? NSArray {
            for i in 0..<itemsArray.count {
                if let itemDic = itemsArray[i] as? NSDictionary {
                    items.append(Item.fromJSON(itemDic))
                }
            }

            preference.items = items
        }

        return preference
    }

    public func toJSONString() -> String {
        //TODO
        return ""
    }

    public func getAmount() -> Double {
        var amount = 0.0
        for item in self.items! {
            amount = amount + (Double(item.quantity) * item.unitPrice)
        }
        return amount
    }

    public func getInstallments() -> Int {
        if self.paymentMethods != nil {
            if (self.paymentMethods!.installments != nil) {
                return self.paymentMethods!.installments!
            } else if (self.paymentMethods!.defaultInstallments != nil) {
                return self.paymentMethods!.defaultInstallments!
            }
        }
        return 1
    }

    public func getExcludedPaymentTypes() -> Set<PaymentTypeId>? {
        if (self.paymentMethods != nil && self.paymentMethods!.excludedPaymentTypes != nil) {
            return self.paymentMethods!.excludedPaymentTypes
        }
        return nil
    }

    public func getExcludedPaymentMethods() -> [String]? {
        if (self.paymentMethods != nil && self.paymentMethods!.excludedPaymentMethods != nil) {
            return self.paymentMethods!.excludedPaymentMethods
        }
        return nil
    }
}
