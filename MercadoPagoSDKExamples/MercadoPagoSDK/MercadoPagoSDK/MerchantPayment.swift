//
//  MerchantPayment.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 31/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

public class MerchantPayment: NSObject {
    public var issuer: Issuer?
    public var cardTokenId: String?
    public var campaignId: Int = 0
    public var installments: Int = 0
    public var items: [Item]
    public var merchantAccessToken: String!
    public var paymentMethod: PaymentMethod!

    public init(items: [Item], installments: Int, issuer: Issuer?, tokenId: String?, paymentMethod: PaymentMethod, campaignId: Int) {
        self.items = items
        self.installments = installments
        self.issuer = issuer
        self.cardTokenId = tokenId
        self.paymentMethod = paymentMethod
        self.campaignId = campaignId
        self.merchantAccessToken = MercadoPagoContext.merchantAccessToken()
    }

    public func toJSONString() -> String {
        let obj: [String:AnyObject] = [
            "card_issuer_id": self.issuer == nil ? JSON.null : (self.issuer)!,
            "card_token": self.cardTokenId == nil ? JSON.null : self.cardTokenId!,
            "campaign_id": self.campaignId == 0 ? JSON.null : String(self.campaignId),
            //TODO : should be plural
//            "items": JSON(self.items[0]),
            "installments": self.installments == 0 ? JSON.null : self.installments,
            "merchant_access_token": self.merchantAccessToken == nil ? JSON.null : self.merchantAccessToken!,
            "payment_method_id": self.paymentMethod._id == nil ? JSON.null : self.paymentMethod._id!
        ]
        return JSON(obj).toString()
    }

}
