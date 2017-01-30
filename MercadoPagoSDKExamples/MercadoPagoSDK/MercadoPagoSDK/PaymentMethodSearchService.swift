//
//  PaymentMethodSearchService.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 15/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class PaymentMethodSearchService: MercadoPagoService {

    public let MP_SEARCH_BASE_URL = "https://api.mercadopago.com"
    public let MP_SEARCH_PAYMENTS_URI = "/checkout/beta/v1/payment_methods/search/options"

    public init() {
        super.init(baseURL: MP_SEARCH_BASE_URL)
    }

    public func getPaymentMethods(excludedPaymentTypes: Set<PaymentTypeId>?, excludedPaymentMethods: [String]?, success: (paymentMethodSearch: PaymentMethodSearch) -> Void, failure: ((error: NSError) -> Void)?) {
        var params = "public_key=" + MercadoPagoContext.publicKey()
        if excludedPaymentTypes != nil {
            let excludedPaymentTypesParams = excludedPaymentTypes!.map({$0.rawValue}).joinWithSeparator(",")
            params = params + "&excluded_payment_types=" + String(excludedPaymentTypesParams).trimSpaces()
        }
        if excludedPaymentMethods != nil {
            let excludedPaymentMethodsParams = excludedPaymentMethods!.joinWithSeparator(",")
            params = params + "&excluded_payment_methods=" + excludedPaymentMethodsParams.trimSpaces()
        }
        self.request(MP_SEARCH_PAYMENTS_URI, params: params, body: nil, method: "GET", success: { (jsonResult) -> Void in
            success(paymentMethodSearch : PaymentMethodSearch.fromJSON(jsonResult as! NSDictionary))
            }, failure: { (_) -> Void in
                //TODO
        })
    }

}
