//
//  MercadoPagoContextTest.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 21/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import XCTest

class MercadoPagoContextTest: BaseTest {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testKeyType() {

        XCTAssertTrue(MercadoPagoContext.privateKey().isEmpty)
        MercadoPagoContext.setPublicKey("public")
        XCTAssertEqual(MercadoPagoContext.keyType(), MercadoPagoContext.PUBLIC_KEY)

        MercadoPagoContext.setPrivateKey("private")
        XCTAssertEqual(MercadoPagoContext.keyType(), MercadoPagoContext.PRIVATE_KEY)

        MercadoPagoContext.setPublicKey("public 2")
        XCTAssertEqual(MercadoPagoContext.keyType(), MercadoPagoContext.PRIVATE_KEY)
    }}
