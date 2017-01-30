//
//  MPFlowBuilder.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 1/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import Foundation

public class MPFlowBuilder: NSObject {

    @available(*, deprecated=2.0, message="Use startCheckoutViewController instead")
    public class func startVaultViewController(amount: Double, supportedPaymentTypes: Set<PaymentTypeId>?, callback: (paymentMethod: PaymentMethod, tokenId: String?, issuer: Issuer?, installments: Int) -> Void) -> VaultViewController {

        return VaultViewController(amount: amount, supportedPaymentTypes: supportedPaymentTypes, callback: callback)

    }

    public class func startCheckoutViewController(preference: CheckoutPreference, callback: (Payment) -> Void) -> CheckoutViewController {
        return CheckoutViewController(preference: preference, callback: callback)

    }

    public class func startPaymentVaultViewController(amount: Double, currencyId: String?, purchaseTitle: String, excludedPaymentTypes: Set<PaymentTypeId>?, excludedPaymentMethods: [String]?, installments: Int = 1, defaultInstallments: Int = 1, callback: (paymentMethod: PaymentMethod, tokenId: String?, issuer: Issuer?, installments: Int) -> Void) -> PaymentVaultViewController {

        return PaymentVaultViewController(amount: amount, currencyId: currencyId, purchaseTitle: purchaseTitle, excludedPaymentTypes: excludedPaymentTypes, excludedPaymentMethods: excludedPaymentMethods, installments: installments, defaultInstallments: defaultInstallments, callback: callback)

    }

}
