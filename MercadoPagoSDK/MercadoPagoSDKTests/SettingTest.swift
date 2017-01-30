//
//  SettingTest.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 1/3/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import XCTest

class SettingTest: BaseTest {

    func testFromJSON() {
        let json: NSDictionary = MockManager.getMockFor("Setting")!
        let settingCodeFromJSON = Setting.fromJSON(json)

        XCTAssertNotNil(settingCodeFromJSON.binMask)
        XCTAssertNotNil(settingCodeFromJSON.securityCode)
        XCTAssertNotNil(settingCodeFromJSON.cardNumber)

    }

    func testToJSON() {
        let setting = MockBuilder.buildSetting()
        let settingJSON = setting.toJSON()

        XCTAssertNotNil(settingJSON["bin"])
        XCTAssertNotNil(settingJSON["card_number"])
        XCTAssertNotNil(settingJSON["security_code"])

    }
}
