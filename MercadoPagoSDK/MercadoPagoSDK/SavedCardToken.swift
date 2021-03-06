//
//  SavedCard.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 31/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

open class SavedCardToken : CardToken {
    
    open var cardId : String?
    open var securityCodeRequired : Bool = true
    
    public init(cardId : String, securityCode : String) {
        super.init()
        self.cardId = cardId
        self.securityCode = securityCode
    }
    
    public init(card : CardInformation, securityCode : String?, securityCodeRequired: Bool) {
        super.init()
        self.cardId = card.getCardId()
        self.securityCode = securityCode
        self.securityCodeRequired = securityCodeRequired
    }
    
    open override func validate() -> Bool {
        return self.validateCardId() && (!securityCodeRequired || self.validateSecurityCodeNumbers())
    }
    
    open func validateCardId() -> Bool {
        return !String.isNullOrEmpty(cardId) && String.isDigitsOnly(cardId!)
    }
    
    open func validateSecurityCodeNumbers() -> Bool {
        let isEmptySecurityCode : Bool = String.isNullOrEmpty(self.securityCode)
        return !isEmptySecurityCode && self.securityCode!.characters.count >= 3 && self.securityCode!.characters.count <= 4
    }
    
    open override func isCustomerPaymentMethod() -> Bool {
        return true
    }
    
    open override func toJSONString() -> String {
        let obj:[String:Any] = [
            "card_id": String.isNullOrEmpty(self.cardId!) ? JSONHandler.null : self.cardId!,
            "security_code" : String.isNullOrEmpty(self.securityCode!) ? JSONHandler.null : self.securityCode!,
            "device" : self.device == nil ? JSONHandler.null : self.device!.toJSONString()
        ]
        return JSONHandler.jsonCoding(obj)
    }
}
