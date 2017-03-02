//
//  PaymentResultScreenPreferenceTest.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 2/23/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import XCTest

class PaymentResultScreenPreferenceTest: BaseTest {
    
    let paymentResultScreenPreference = PaymentResultScreenPreference()
    
    func testSetTitle() {
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getApprovedTitle(), "¡Listo, se acreditó tu pago!".localized)
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingTitle(), "Estamos procesando el pago".localized)
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedTitle(), "Uy, no pudimos procesar el pago".localized)
        
        paymentResultScreenPreference.setApprovedTitle(title: "1")
        paymentResultScreenPreference.setPendingTitle(title: "2")
        paymentResultScreenPreference.setRejectedTitle(title: "3")
        
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getApprovedTitle(), "1")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingTitle(), "2")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedTitle(), "3")
    }
    
    func testSetSubtitle() {
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getApprovedSubtitle(), "")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingSubtitle(), "")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedSubtitle(), "")
        
        paymentResultScreenPreference.setApprovedSubtitle(subtitle: "1")
        paymentResultScreenPreference.setPendingSubtitle(subtitle: "2")
        paymentResultScreenPreference.setRejectedSubtitle(subtitle: "3")
        
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getApprovedSubtitle(), "1")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingSubtitle(), "2")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedSubtitle(), "3")
    }
    
    func testSetContentTitle() {
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingContetTitle(), "¿Qué puedo hacer?".localized)
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedContetTitle(), "¿Qué puedo hacer?".localized)
        
        paymentResultScreenPreference.setPendingContentTitle(title: "1")
        paymentResultScreenPreference.setRejectedContentTitle(title: "2")
        
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingContetTitle(), "1")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedContetTitle(), "2")
    }
    
    func testSetContentText() {
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingContentText(), "")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedContentText(), "")
        
        paymentResultScreenPreference.setPendingContentText(text: "1")
        paymentResultScreenPreference.setRejectedContentText(text: "2")
        
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingContentText(), "1")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedContentText(), "2")
    }
    
    func testSetIconSubtext() {
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedIconSubtext(), "Algo salió mal… ".localized)
        
        paymentResultScreenPreference.setRejectedIconSubtext(text: "lala")
        
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedIconSubtext(), "lala")
    }
    
    func testSetSecondaryExitButton() {
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getApprovedSecondaryButtonText(), "")
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getApprovedSecondaryButtonCallback() == nil)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingSecondaryButtonText(), "Pagar con otro medio".localized)
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingSecondaryButtonCallback() == nil)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedSecondaryButtonText(), "Pagar con otro medio".localized)
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedSecondaryButtonCallback() == nil)
        
        paymentResultScreenPreference.setApprovedSecondaryExitButton(callback: { (paymentResult) in
            
        }, text: "1")
        
        paymentResultScreenPreference.setPendingSecondaryExitButton(callback: { (paymentResult) in
    
        }, text: "2")
        
        paymentResultScreenPreference.setRejectedSecondaryExitButton(callback: { (paymentResult) in
            
        }, text: "3")
        
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getApprovedSecondaryButtonText(), "1")
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getApprovedSecondaryButtonCallback() != nil)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingSecondaryButtonText(), "2")
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getPendingSecondaryButtonCallback() != nil)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedSecondaryButtonText(), "3")
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getRejectedSecondaryButtonCallback() != nil)
    }
    
    func testSetHeaderIcon() {
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.pendingIconName, "iconoAcreditado")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.pendingIconBundle, MercadoPago.getBundle())

        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.rejectedIconName, "congrats_iconoTcError")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.rejectedIconBundle, MercadoPago.getBundle())
        
        paymentResultScreenPreference.setPendingHeaderIcon(name: "lala", bundle: Bundle.main)
        paymentResultScreenPreference.setRejectedHeaderIcon(name: "lalala", bundle: Bundle.main)
        
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.pendingIconName, "lala")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.pendingIconBundle, Bundle.main)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.rejectedIconName, "lalala")
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.rejectedIconBundle, Bundle.main)

    }
    
    func testDisableSecondaryButton() {
        XCTAssertFalse(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isPendingSecondaryExitButtonDisable())
        XCTAssertFalse(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isRejectedSecondaryExitButtonDisable())
        
        paymentResultScreenPreference.disablePendingSecondaryExitButton()
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isPendingSecondaryExitButtonDisable())
        
        paymentResultScreenPreference.disableRejectdSecondaryExitButton()
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isRejectedSecondaryExitButtonDisable())
    }
    
    func testDisableContentText() {
        XCTAssertFalse(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isPendingContentTextDisable())
        XCTAssertFalse(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isRejectedContentTextDisable())
        
        paymentResultScreenPreference.disablePendingContentText()
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isPendingContentTextDisable())
        
        paymentResultScreenPreference.disableRejectedContentText()
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isRejectedContentTextDisable())
    }
    
    func testDisableContentTitle() {
        XCTAssertFalse(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isRejectedContentTitleDisable())
        
        paymentResultScreenPreference.disableRejectedContentTitle()
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isRejectedContentTitleDisable())
    }
    
    func testSetExitTitle() {
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getExitButtonTitle(), "Continuar".localized)
        
        paymentResultScreenPreference.setExitButtonTitle(title: "lala")
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssertEqual(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.getExitButtonTitle(), "lala")
        
    }
    
    func testApprovedBodyDisables() {
        XCTAssertFalse(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isAmountDisable())
        XCTAssertFalse(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isPaymentMethodDisable())
        XCTAssertFalse(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isPaymentIdDisable())
        
        paymentResultScreenPreference.disableApprovedAmount()
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isAmountDisable())
        
        paymentResultScreenPreference.disableApprovedPaymentMethodInfo()
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isPaymentMethodDisable())
        
        paymentResultScreenPreference.disableApprovedReceipt()
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isPaymentIdDisable())
    }
    
    func testDisableChangePaymentMethodCell() {
        XCTAssertFalse(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isSelectAnotherPaymentMethodDisableCell())
        
        paymentResultScreenPreference.disableChangePaymentMethodOptionCell()
        MercadoPagoCheckout.setPaymentResultScreenPreference(paymentResultScreenPreference)
        
        XCTAssert(MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isSelectAnotherPaymentMethodDisableCell())
    }
}
