//
//  MPPaymentTest.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 12/26/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit
import XCTest

class MPPaymentTest: NSObject {

    var mpPayment: MPPayment?

    func testToJSON() {
        self.mpPayment = MPPayment(email: "email", preferenceId: "prefId", publicKey: "pk", paymentMethodId: "pmId")
        var jsonResult = mpPayment!.toJSON()

        XCTAssertEqual(jsonResult["pref_id"] as? String, "prefId")
        XCTAssertEqual(jsonResult["public_key"] as? String, "pk")
        XCTAssertEqual(jsonResult["payment_method_id"] as? String, "pmId")
        XCTAssertNotNil(jsonResult["payer"] as? Payer)
        var payer = jsonResult["payer"] as? Payer
        XCTAssertEqual(payer?.email, "email")

        self.mpPayment = MPPayment(email: "email_test", preferenceId: "prefId", publicKey: "", paymentMethodId: "pmId", installments : 3, issuerId : "issuerId", tokenId : "123")
        jsonResult = self.mpPayment!.toJSON()

        XCTAssertEqual(jsonResult["email"] as? String, "email_test")
        XCTAssertEqual(jsonResult["pref_id"] as? String, "prefId")
        XCTAssertEqual(jsonResult["public_key"] as? String, "pk_test")
        XCTAssertEqual(jsonResult["payment_method_id"] as? String, "pmId")
        XCTAssertEqual(jsonResult["installments"] as? String, "3")
        XCTAssertEqual(jsonResult["issuerId"] as? String, "issuerId")
        XCTAssertEqual(jsonResult["tokenId"] as? String, "123")
        XCTAssertNotNil(jsonResult["payer"] as? Payer)
        payer = jsonResult["payer"] as? Payer
        XCTAssertEqual(payer?.email, "email")

    }
}

class CustomerPaymentTest {

    var customerPayment: CustomerPayment?

    func testToJSON() {
        self.customerPayment = CustomerPayment(email: "email", preferenceId: "prefId", publicKey: "pk", paymentMethodId: "pmId", customerId: "customerId")
        var customerPaymentResult = self.customerPayment!.toJSON()

        XCTAssertEqual(customerPaymentResult["pref_id"] as? String, "prefId")
        XCTAssertEqual(customerPaymentResult["public_key"] as? String, "pk_test")
        XCTAssertEqual(customerPaymentResult["payment_method_id"] as? String, "pmId")
        XCTAssertNil(customerPaymentResult["installments"] as? String, "3")
        XCTAssertNil(customerPaymentResult["issuerId"] as? String, "issuerId")
        XCTAssertNil(customerPaymentResult["tokenId"] as? String, "123")
        XCTAssertNotNil(customerPaymentResult["payer"] as? Payer)
        var payer = customerPaymentResult["payer"] as? Payer
        XCTAssertEqual(payer?.email, "email")
        XCTAssertEqual(payer?._id, "customerId")

        self.customerPayment = CustomerPayment(email: "email_test", preferenceId: "prefId", publicKey: "", paymentMethodId: "pmId", installments : 3, issuerId : "issuerId", tokenId : "123", customerId : "111")
        customerPaymentResult = self.customerPayment!.toJSON()

        XCTAssertEqual(customerPaymentResult["pref_id"] as? String, "prefId")
        XCTAssertEqual(customerPaymentResult["public_key"] as? String, "pk_test")
        XCTAssertEqual(customerPaymentResult["payment_method_id"] as? String, "pmId")
        XCTAssertEqual(customerPaymentResult["installments"] as? String, "3")
        XCTAssertEqual(customerPaymentResult["issuerId"] as? String, "issuerId")
        XCTAssertEqual(customerPaymentResult["tokenId"] as? String, "123")
        XCTAssertNotNil(customerPaymentResult["payer"] as? Payer)
        payer = customerPaymentResult["payer"] as? Payer
        XCTAssertEqual(payer?.email, "email")
        XCTAssertEqual(payer?._id, "123")

    }

}

class BlacklabelPaymentTest {

    var blacklabelPayment: BlacklabelPayment?

    func testToJSON() {

        MercadoPagoContext.setPayerAccessToken("payerAccessToken")
        self.blacklabelPayment = BlacklabelPayment(email: "email", preferenceId: "prefId", publicKey: "pk", paymentMethodId: "pmId", installments : 2, issuerId : "310", tokenId : "tokenId")
        let jsonResult = self.blacklabelPayment!.toJSON()

        XCTAssertEqual(jsonResult["pref_id"] as? String, "prefId")
        XCTAssertEqual(jsonResult["public_key"] as? String, "pk_test")
        XCTAssertEqual(jsonResult["payment_method_id"] as? String, "pmId")
        XCTAssertEqual(jsonResult["installments"] as? String, "2")
        XCTAssertEqual(jsonResult["issuerId"] as? String, "310")
        XCTAssertEqual(jsonResult["tokenId"] as? String, "tokenId")
        XCTAssertNotNil(jsonResult["payer"] as? Payer)
        let payer = jsonResult["payer"] as? GroupsPayer
        XCTAssertEqual(payer!.email, "email")
        let payerJson = payer!.toJSON()
        XCTAssertEqual(payerJson["access_token"] as? String, "payerAccessToken")

    }

}

class MPPaymentFactoryTest {

    func testCreateMPPayment() {

        let regularPayment = MPPaymentFactory.createMPPayment(email: "email", preferenceId: "prefId", publicKey: "pk", paymentMethodId: "rapipago", isBlacklabelPayment : false)

        XCTAssertEqual(String(describing: regularPayment.classForCoder), String(describing: MPPayment.classForCoder()))

        let blacklabelPayment = MPPaymentFactory.createMPPayment(email: "email", preferenceId: "prefId", publicKey: "pk", paymentMethodId: "master", isBlacklabelPayment : true)

        XCTAssertEqual(String(describing: blacklabelPayment.classForCoder), String(describing:BlacklabelPayment.classForCoder()))

        let customerPayment = MPPaymentFactory.createMPPayment(email: "email", preferenceId: "prefId", publicKey: "pk", paymentMethodId: "visa", customerId : "customerId", isBlacklabelPayment : false)

        XCTAssertEqual(String(describing: customerPayment.classForCoder), String(describing: CustomerPayment.classForCoder()))

    }

}
