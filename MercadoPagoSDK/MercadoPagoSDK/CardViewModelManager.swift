//
//  CardViewModelManager.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 9/8/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class CardViewModelManager: NSObject {

    
    var paymentMethods : [PaymentMethod]?
    var paymentMethod : PaymentMethod?
    var customerCard : CardInformation?
    var token : Token?
    var cardToken : CardToken?
    var paymentSettings : PaymentPreference?
    var amount : Double?
    
    let textMaskFormater = TextMaskFormater(mask: "XXXX XXXX XXXX XXXX")
    let textEditMaskFormater = TextMaskFormater(mask: "XXXX XXXX XXXX XXXX", completeEmptySpaces :false)
    
    init(amount : Double, paymentMethods : [PaymentMethod]?, paymentMethod : PaymentMethod? = nil, customerCard : CardInformation? = nil, token : Token? = nil, paymentSettings : PaymentPreference?){
        self.amount = amount
        self.paymentMethods = paymentMethods
        self.paymentMethod = paymentMethod
        self.customerCard = customerCard
        self.token = token
        self.paymentSettings = paymentSettings
    }
    
    
    func cvvLenght() -> Int{
        var lenght : Int
        
        if self.customerCard != nil {
            lenght = (self.customerCard?.getCardSecurityCode().length)!
        } else {
            if ((paymentMethod?.settings == nil)||(paymentMethod?.settings.count == 0)){
                lenght = 3 // Default
            }else{
                lenght = (paymentMethod?.settings[0].securityCode.length)!
            }
        }
        return lenght
    }
    
    func validInputCVV(text : String) -> Bool{
        if( text.characters.count > self.cvvLenght() ){
            return false
        }
        let num = Int(text)
        return (num != nil)
    }
 



}
