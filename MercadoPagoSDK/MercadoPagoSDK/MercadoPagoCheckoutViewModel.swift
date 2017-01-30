//
//  CheckoutViewModel.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 1/23/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

public enum CheckoutStep: String {
    case SEARCH_PAYMENT_METHODS
    case PAYMENT_METHOD
    case PM_OFF
    case CARD_FORM
    case CREDIT_DEBIT
    case ISSUER
    case IDENTIFICATION
    case PAYER_COST
    case REVIEW_AND_CONFIRM
    case CONGRATS
}

open class MercadoPagoCheckoutViewModel: NSObject {

    let amount: Double = 1000
    var paymentMethods: [PaymentMethod]?
    var cardToken: CardToken?
    var payerCost: PayerCost?

    //--- PAYMENT DATA

    var selectedPaymentMethod: PaymentMethod?
    var selectedIssuer: Issuer?
    var selectedPayerCost: PayerCost?

    //----------------

    var next: CheckoutStep = .SEARCH_PAYMENT_METHODS

    public func getPaymentPreferences() -> PaymentPreference? {
        return nil
    }

    public func cardFormManager() -> CardViewModelManager {
        return CardViewModelManager(amount : amount, paymentMethods :nil, paymentSettings : nil)
    }
    public func debitCreditViewModel() -> CardAdditionalStepViewModel {
        var pms: [PaymentMethod] = []
        if let _ = paymentMethods {
            pms = paymentMethods!
        }
        return CardAdditionalStepViewModel(paymentMethods: pms, issuer: nil, token: nil, amount: nil, paymentPreference: nil, installment: nil, callback: nil)
    }

    public func issuerViewModel() -> CardAdditionalStepViewModel {
        var pms: [PaymentMethod] = []
        if let pm = selectedPaymentMethod {
            pms = [pm]
        }
        return CardAdditionalStepViewModel(paymentMethods: pms, issuer: nil, token: cardToken, amount: nil, paymentPreference: nil, installment: nil, callback: nil)
    }

    public func payerCostViewModel() -> CardAdditionalStepViewModel {
        var pms: [PaymentMethod] = []
        if let pm = selectedPaymentMethod {
            pms = [pm]
        }
        return CardAdditionalStepViewModel(paymentMethods: pms, issuer: selectedIssuer, token: cardToken, amount: amount, paymentPreference: getPaymentPreferences(), installment: nil, callback: nil)
    }

    public func updateCheckoutModel(paymentMethods: [PaymentMethod], cardToken: CardToken?) {
        self.paymentMethods = paymentMethods
        self.selectedPaymentMethod = self.paymentMethods?[0] // Ver si son mas de uno
        self.cardToken = cardToken
        self.next = CheckoutStep.ISSUER
    }

    public func updateCheckoutModel(paymentMethod: PaymentMethod?) {
        self.selectedPaymentMethod = paymentMethod
    }

    public func updateCheckoutModel(issuer: Issuer?) {
        self.selectedIssuer = issuer
        self.next = CheckoutStep.PAYER_COST
    }
    public func updateCheckoutModel(payerCost: PayerCost?) {
        self.selectedPayerCost = payerCost
    }

    public func nextStep() -> CheckoutStep {
        // --  --
        return next
    }

}
