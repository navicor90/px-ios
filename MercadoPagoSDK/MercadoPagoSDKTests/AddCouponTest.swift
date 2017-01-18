//
//  AddCouponTest.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 1/15/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import XCTest

class AddCouponViewModelTest: BaseTest {
    
    var viewModel : AddCouponViewModel?
    
    let amount : Double = 1000.0
    
    override func setUp() {
        super.setUp()
        viewModel = AddCouponViewModel(amount: amount)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCouponWOCode() {
        viewModel?.getCoupon(code: "", success: { () in
            self.checkDiscount()
        }, failure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    
    func testCouponCode() {
        viewModel?.getCoupon(code: "Prueba", success: { () in
            self.checkCouponCode()
        }, failure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    
    
    func checkCouponCode(){
        XCTAssertEqual(viewModel?.coupon?.getDescription(), "$15 de descuento")
        XCTAssertEqual(viewModel?.coupon?.amount_off, "15")
        XCTAssertEqual(viewModel?.coupon?.percent_off, "0")
    }
    
    func checkDiscount(){
        XCTAssertEqual(viewModel?.coupon?.getDescription(), "10 % de descuento")
        XCTAssertEqual(viewModel?.coupon?.amount_off, "0")
        XCTAssertEqual(viewModel?.coupon?.percent_off, "10")
    }
    
}
