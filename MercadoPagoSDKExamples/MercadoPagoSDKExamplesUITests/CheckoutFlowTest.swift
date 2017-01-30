//
//  CheckoutFlowTest.swift
//  MercadoPagoSDKExamples
//
//  Created by Maria cristina rodriguez on 11/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//
import XCTest

open class CheckoutFlowTest: MercadoPagoUITest {

    func testfullCHO() {
        self.testCheckOutWithCard()
        self.testCheckOutWithEfectivo()
        self.testCheckOutWithRedLink()
    }

    func testCheckOutWithCard() {
        let tablesQuery = CheckoutFlowTest.application.tables
        tablesQuery.cells.element(boundBy: 0).tap()
        tablesQuery.cells.element(boundBy: 0).tap()
        CardFormActions.testCard(visaGaliciaII(), user: approvedUser())
        tablesQuery.cells.element(boundBy: 0).tap()
        tablesQuery.buttons["Pagar"].tap()
        let buton = CheckoutFlowTest.application.buttons["Seguir comprando"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: buton, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)

        buton.tap()

    }

    func testCheckOutWithEfectivo() {

        let tablesQuery = CheckoutFlowTest.application.tables
        tablesQuery.cells.element(boundBy: 0).tap()
        tablesQuery.cells.element(boundBy: 1).tap()
        tablesQuery.cells.element(boundBy: 0).tap()
        tablesQuery.buttons["Pagar"].tap()
        let buton = CheckoutFlowTest.application.buttons["Seguir comprando"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: buton, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)

        buton.tap()

    }

    func testCheckOutWithRedLink() {

        let tablesQuery = CheckoutFlowTest.application.tables
        tablesQuery.cells.element(boundBy: 0).tap()
        tablesQuery.cells.element(boundBy: 2).tap()
        tablesQuery.cells.element(boundBy: 0).tap()
        tablesQuery.buttons["Pagar"].tap()
        let buton = CheckoutFlowTest.application.buttons["Seguir comprando"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: buton, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)

        buton.tap()

    }

}
