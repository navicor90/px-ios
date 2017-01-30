//
//  FlowPreferenceTest.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 1/24/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import XCTest

class FlowPreferenceTest: BaseTest {

    func testDisableReviewAndConfirmScreen() {
        let flowPreference = FlowPreference()
        flowPreference.disableReviewAndConfirmScreen()
        XCTAssertFalse(flowPreference.isReviewAndConfirmScreenEnable())
    }

    func testDisablePaymentResultScreen() {
        let flowPreference = FlowPreference()
        flowPreference.disablePaymentResultScreen()
        XCTAssertFalse(flowPreference.isPaymentResultScreenEnable())
    }

    func testDisablePaymentApprovedScreen() {
        let flowPreference = FlowPreference()
        flowPreference.disablePaymentApprovedScreen()
        XCTAssertFalse(flowPreference.isPaymentApprovedScreenEnable())
    }

    func testDisablePaymentRejectedScreen() {
        let flowPreference = FlowPreference()
        flowPreference.disablePaymentRejectedScreen()
        XCTAssertFalse(flowPreference.isPaymentRejectedScreenEnable())
    }

    func testEnablePaymentPendingScreen() {
        let flowPreference = FlowPreference()
        flowPreference.disablePaymentPendingScreen()
        XCTAssertFalse(flowPreference.isPaymentPendingScreenEnable())
    }
    func testEnableReviewAndConfirmScreen() {
        let flowPreference = FlowPreference()
        XCTAssert(flowPreference.isReviewAndConfirmScreenEnable())
        flowPreference.disableReviewAndConfirmScreen()
        flowPreference.enableReviewAndConfirmScreen()
        XCTAssert(flowPreference.isReviewAndConfirmScreenEnable())
    }

    func testEnablePaymentResultScreen() {
        let flowPreference = FlowPreference()
        XCTAssert(flowPreference.isPaymentResultScreenEnable())
        flowPreference.disablePaymentResultScreen()
        flowPreference.enablePaymentResultScreen()
        XCTAssert(flowPreference.isPaymentResultScreenEnable())
    }

    func testEnablePaymentApprovedScreen() {
        let flowPreference = FlowPreference()
        XCTAssert(flowPreference.isPaymentApprovedScreenEnable())
        flowPreference.disablePaymentApprovedScreen()
        flowPreference.enablePaymentApprovedScreen()
        XCTAssert(flowPreference.isPaymentApprovedScreenEnable())
    }

    func testEnablePaymentRejectedScreen() {
        let flowPreference = FlowPreference()
        XCTAssert(flowPreference.isPaymentRejectedScreenEnable())
        flowPreference.disablePaymentRejectedScreen()
        flowPreference.enablePaymentRejectedScreen()
        XCTAssert(flowPreference.isPaymentRejectedScreenEnable())
    }

    func testEnablePaymentPendingdScreen() {
        let flowPreference = FlowPreference()
        XCTAssert(flowPreference.isPaymentPendingScreenEnable())
        flowPreference.disablePaymentPendingScreen()
        flowPreference.enablePaymentPendingScreen()
        XCTAssert(flowPreference.isPaymentPendingScreenEnable())
    }

    func testIsPaymentSearchScreenEnable() {
        let flowPreference = FlowPreference()
        XCTAssert(flowPreference.isPaymentSearchScreenEnable())
    }

}
