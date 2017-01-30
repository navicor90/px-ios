//
//  CardFlowTest.swift
//  MercadoPagoSDKExamples
//
//  Created by Maria cristina rodriguez on 11/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import XCTest

class CardFlowTest: MercadoPagoUITest {

    func testCardForm() {

        testApproved(diners())
    }
 /*
    func testAllCards(){
      
      //  for (_, card) in cardsTestArray!.enumerate() {
        for (_, card) in cardsForDemo!.enumerate() {
            print("---------------------------------------------------------")
            print("Testing  \(card.name)")
            testApproved(card)
            backToMenu()
        }
    }
    
    */
    func testApproved(_ card: TestCard) {
        self.testCard(card, user: approvedUser())
    }

    func testCard(_ card: TestCard, user: TestUser) {
        let tablesQuery = CardFlowTest.application.tables
        tablesQuery.cells.element(boundBy: 1).tap()
        tablesQuery.cells.element(boundBy: 1).tap()
        CardFormActions.testCard(card, user: user)

    }

    func backToMenu() {

        let cMoQuieresPagarNavigationBar = XCUIApplication().navigationBars[""]
        cMoQuieresPagarNavigationBar.children(matching: .button).element(boundBy: 1).tap()
        cMoQuieresPagarNavigationBar.children(matching: .button).element(boundBy: 0).tap()

    }

}
