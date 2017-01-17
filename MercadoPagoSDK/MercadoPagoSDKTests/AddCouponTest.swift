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
    
    override func setUp() {
        super.setUp()
        viewModel = AddCouponViewModel(amount: 1000)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        viewModel?.getCoupon(code: "Prueba", success: { () in
            print(self.viewModel?.coupon?.name)
        }, failure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    
}
