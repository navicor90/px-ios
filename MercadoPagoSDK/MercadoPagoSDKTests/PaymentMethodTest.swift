//
//  PaymentMethodTest.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 1/3/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import XCTest

class PaymentMethodTest: BaseTest {

    func testIsIssuerRequired() {

    }

    func testFromJSON() {
        let json: NSDictionary = MockManager.getMockFor("PaymentMethod")!
        let paymentMethodFromJSON = PaymentMethod.fromJSON(json)

        XCTAssertEqual(paymentMethodFromJSON._id, "visa")
        XCTAssertEqual(paymentMethodFromJSON.name, "Visa")
        XCTAssertEqual(paymentMethodFromJSON.paymentTypeId, "credit_card")
        XCTAssertEqual(paymentMethodFromJSON.status, "active")
        XCTAssertEqual(paymentMethodFromJSON.secureThumbnail, "https://www.mercadopago.com/org-img/MP3/API/logos/visa.gif")
        XCTAssertEqual(paymentMethodFromJSON.thumbnail, "http://img.mlstatic.com/org-img/MP3/API/logos/visa.gif")
        XCTAssertEqual(paymentMethodFromJSON.deferredCapture, "supported")
        XCTAssertEqual(paymentMethodFromJSON.minAllowedAmount, 0)
        XCTAssertEqual(paymentMethodFromJSON.maxAllowedAmount, 250000)
        XCTAssertEqual(paymentMethodFromJSON.accreditationTime, 2880)

    }

    func testToJSON() {
        let paymentMethod = MockBuilder.buildPaymentMethod("paymentMethodId", name: "name")
        paymentMethod.status = "active"
        paymentMethod.secureThumbnail = "secureThumbnail"
        paymentMethod.thumbnail = "thumbnail"
        paymentMethod.deferredCapture = "supported"
        paymentMethod.minAllowedAmount = 100
        paymentMethod.maxAllowedAmount = 20000
        paymentMethod.accreditationTime = 10

        let paymentMethodJson = paymentMethod.toJSON()

        XCTAssertNotNil(paymentMethod.toJSONString())

        XCTAssertEqual(paymentMethodJson["id"] as! String, "paymentMethodId")
        XCTAssertEqual(paymentMethodJson["name"] as! String, "name")
        XCTAssertEqual(paymentMethodJson["payment_type_id"] as! String, "credit_card")
        XCTAssertEqual(paymentMethodJson["status"] as! String, "active")
        XCTAssertEqual(paymentMethodJson["secure_thumbnail"] as! String, "secureThumbnail")
        XCTAssertEqual(paymentMethodJson["thumbnail"] as! String, "thumbnail")
        XCTAssertEqual(paymentMethodJson["deferred_capture"] as! String, "supported")
        XCTAssertEqual(paymentMethodJson["min_allowed_amount"] as! Double, 100)
        XCTAssertEqual(paymentMethodJson["max_allowed_amount"] as! Double, 20000)
        XCTAssertEqual(paymentMethodJson["accreditation_time"] as! Int, 10)

    }

}
