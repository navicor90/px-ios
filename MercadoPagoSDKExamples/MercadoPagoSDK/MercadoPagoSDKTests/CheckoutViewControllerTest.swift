//
//  CheckoutViewControllerTest.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 22/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import XCTest

class CheckoutViewControllerTest: BaseTest {

    var checkoutViewController: MockCheckoutViewController?
    var preference: CheckoutPreference?

    override func setUp() {
        super.setUp()
        self.preference = MockBuilder.buildCheckoutPreference()
        checkoutViewController = MockCheckoutViewController(preference: preference!, callback: {(_) -> Void in

        })
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInit() {
        XCTAssertEqual(checkoutViewController!.preference, preference)
        XCTAssertEqual(checkoutViewController!.publicKey, MercadoPagoContext.publicKey())
        XCTAssertEqual(checkoutViewController!.accessToken, MercadoPagoContext.merchantAccessToken())
        XCTAssertNil(checkoutViewController!.paymentMethod)
    }

    func testViewDidLoadStartPaymentVault() {
        self.checkoutViewController?.loadView()
        XCTAssertTrue(checkoutViewController!.paymentVaultLoaded)

        let cell = checkoutViewController?.tableView(checkoutViewController!.checkoutTable, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 1)) as! SelectPaymentMethodCell
        XCTAssertEqual(cell.selectPaymentMethodLabel!.text, "Selecciona método de pago...")
        XCTAssertTrue(checkoutViewController!.confirmPaymentButton.hidden)

    }

}
