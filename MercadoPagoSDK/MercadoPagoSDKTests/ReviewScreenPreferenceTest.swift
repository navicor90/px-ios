//
//  ReviewScreenPreferenceTest.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 3/2/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import XCTest

class ReviewScreenPreferenceTest: BaseTest {
    
    let reviewScreenPreference = ReviewScreenPreference()
    
    func testSetTitle() {
        
        XCTAssertEqual(reviewScreenPreference.getTitle(), "Confirma tu compra".localized)
        
        reviewScreenPreference.setTitle(title: "1")
        MercadoPagoCheckout.setReviewScreenPreference(reviewScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.reviewScreenPreference.getTitle(), "1")
    }
    
    func testSetProductDetail() {
        
        XCTAssertEqual(reviewScreenPreference.getProductsTitle(), "Productos".localized)
        
        reviewScreenPreference.setProductsDetail(productsTitle: "1")
        MercadoPagoCheckout.setReviewScreenPreference(reviewScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.reviewScreenPreference.getProductsTitle(), "1")
    }
    
    func testSetConfirmButtonText() {
        
        XCTAssertEqual(reviewScreenPreference.getConfirmButtonText(), "Confirmar".localized)
        
        reviewScreenPreference.setConfirmButtonText(confirmButtonText: "1")
        MercadoPagoCheckout.setReviewScreenPreference(reviewScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.reviewScreenPreference.getConfirmButtonText(), "1")
    }
    
    func testSetCancelButtonText() {
        
        XCTAssertEqual(reviewScreenPreference.getCancelButtonTitle(), "Cancelar Pago".localized)
        
        reviewScreenPreference.setCancelButtonText(cancelButtonText: "1")
        MercadoPagoCheckout.setReviewScreenPreference(reviewScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.reviewScreenPreference.getCancelButtonTitle(), "1")
    }
    
    func testSetSecondaryButtonText() {
        XCTAssertEqual(reviewScreenPreference.getSecondaryConfirmButtonText(), "Confirmar".localized)
        
        reviewScreenPreference.setSecondaryConfirmButtonText(secondaryConfirmButtonText: "1")
        
        MercadoPagoCheckout.setReviewScreenPreference(reviewScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.reviewScreenPreference.getSecondaryConfirmButtonText(), "1")
        
    }
    
    func testIsChangePaymentMethodDisable() {
        XCTAssert(reviewScreenPreference.isChangeMethodOptionEnabled())
        
        reviewScreenPreference.disableChangeMethodOption()
        
        XCTAssertFalse(reviewScreenPreference.isChangeMethodOptionEnabled())
        
        reviewScreenPreference.enableChangeMethodOption()
        
        XCTAssert(reviewScreenPreference.isChangeMethodOptionEnabled())
    }
}
