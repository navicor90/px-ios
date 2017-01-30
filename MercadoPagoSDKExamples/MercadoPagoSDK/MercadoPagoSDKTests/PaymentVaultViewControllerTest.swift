//
//  PaymentVaultViewControllerTest.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 22/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import XCTest

class PaymentVaultViewControllerTest: BaseTest {

    var paymentVaultViewController: PaymentVaultViewController?

    override func setUp() {
        super.setUp()
        self.paymentVaultViewController = PaymentVaultViewController(amount: 7.5, currencyId: "MXN", purchaseTitle: "Purchase title", excludedPaymentTypes:  MockBuilder.getMockPaymentTypeIds(), excludedPaymentMethods: ["visa"], installments: 1, defaultInstallments: 1, callback: { (_, _, _, installments) -> Void in

        })
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInit() {
        XCTAssertEqual(paymentVaultViewController!.merchantBaseUrl, MercadoPagoContext.baseURL())
        XCTAssertEqual(paymentVaultViewController!.publicKey, MercadoPagoContext.publicKey())
        XCTAssertEqual(paymentVaultViewController!.merchantAccessToken, MercadoPagoContext.merchantAccessToken())
        XCTAssertNil(paymentVaultViewController?.paymentMethodsSearch)

    }

}
