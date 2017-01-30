//
//  MockBuilder.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 22/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import Foundation

class MockBuilder: NSObject {

    class func buildCheckoutPreference() -> CheckoutPreference {
        let preference = CheckoutPreference()
        preference._id = "xxx"
        preference.items = [self.buildItem("itemId", quantity: 1, unitPrice: 10), self.buildItem("itemId2", quantity: 2, unitPrice: 10)]
        preference.payer = self.buildPayer(1, type: "type")
        return preference
    }

    class func buildItem(id: String, quantity: Int, unitPrice: Double) -> Item {
        return Item(_id: id, title : "item title", quantity: quantity, unitPrice: unitPrice)
    }

    class func buildPayer(id: NSNumber, type: String) -> Payer {
        let payer =  Payer()
        payer._id = id
        payer.type = type
        return payer
    }

    class func buildPreferencePaymentMethods() -> PreferencePaymentMethods {
        let preferencePM = PreferencePaymentMethods()
        preferencePM.defaultInstallments = 1
        preferencePM.defaultPaymentMethodId = "visa"
        preferencePM.excludedPaymentMethods = ["amex"]
        preferencePM.excludedPaymentTypes = self.getMockPaymentTypeIds()
        return preferencePM
    }

    class func buildPaymentMethod(id: String) -> PaymentMethod {
        let paymentMethod = PaymentMethod()
        paymentMethod._id = id
        return paymentMethod
    }

    class func getMockPaymentMethods() -> [PaymentMethod] {
        return [self.buildPaymentMethod("amex"), self.buildPaymentMethod("oxxo")]
    }

    class func getMockPaymentTypeIds() -> Set<PaymentTypeId> {
        return Set([PaymentTypeId.BITCOIN, PaymentTypeId.ACCOUNT_MONEY])
    }
}
