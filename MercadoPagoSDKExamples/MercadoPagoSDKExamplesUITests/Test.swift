//
//  Test.swift
//  MercadoPagoSDKExamples
//
//  Created by Maria cristina rodriguez on 11/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import XCTest

class Test: XCTestCase {

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {

        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Components de UI"].tap()
        tablesQuery.staticTexts["Selección de medio de pago completa"].tap()
        tablesQuery.staticTexts["Tarjeta de crédito"].tap()
      /*  app.textFields["Número de tarjeta"]

        let textField = app.textFields["Número de tarjeta"]
        
        */

        app.textFields["Número de tarjeta"].tap()
        let cardNumberField = app.textFields["Número de tarjeta"]
        cardNumberField.typeText("450995")

        let continuarButton = app.navigationBars.buttons["Continuar"]
        continuarButton.tap()
        cardNumberField.typeText("3566233704")
        continuarButton.tap()
        let cardholderNameField = app.textFields["Nombre y apellido"]
        cardholderNameField.typeText("APRO")
        continuarButton.tap()

        let expirationDateField = app.textFields["Fecha de expiración"]
        expirationDateField.typeText("1122")
        continuarButton.tap()

        let securityCodeField = app.textFields["Código de seguridad"]
        securityCodeField.typeText("123")
        continuarButton.tap()

        let identificationNumberField = app.textFields["Número"]
        identificationNumberField.typeText("12123123")

        continuarButton.pressForDuration(0.6)

        XCUIApplication().tables.staticTexts["3 de $ 397 29 ( $ 1.191 89 ) "].pressForDuration(1.3)

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

    }

}
