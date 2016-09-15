//
//  PaymentMethodsSearch.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 15/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//
import Foundation

public class PaymentMethodSearch: Equatable {
    
    var groups : [PaymentMethodSearchItem]!
    var paymentMethods : [PaymentMethod]!
    var customerOptions : [CustomerPaymentMethod]?
    var cards : [CardInformation]?
    var accountMoney : AccountMoneyPaymentMethod?

    public class func fromJSON(json : NSDictionary) -> PaymentMethodSearch {
        let pmSearch = PaymentMethodSearch()
        
        var groups = [PaymentMethodSearchItem]()
        if let groupsJson = json["groups"] as? NSArray {
            for i in 0..<groupsJson.count {
                if let groupDic = groupsJson[i] as? NSDictionary {
                    groups.append(PaymentMethodSearchItem.fromJSON(groupDic))
                }
            }
            pmSearch.groups = groups
        }
        
        var paymentMethods = [PaymentMethod]()
        if let paymentMethodsJson = json["payment_methods"] as? NSArray {
            for i in 0..<paymentMethodsJson.count {
                if let paymentMethodsDic = paymentMethodsJson[i] as? NSDictionary {
                    let currentPaymentMethod = PaymentMethod.fromJSON(paymentMethodsDic)
                    paymentMethods.append(currentPaymentMethod)
                }
             
            }
            pmSearch.paymentMethods = paymentMethods
        }
        
        var customerPaymentMethods = [CustomerPaymentMethod]()
        if let customerPaymentMethodsJson = json["custom_options"] as? NSArray {
            for i in 0..<customerPaymentMethodsJson.count {
                if let customerPaymentMethodDic = customerPaymentMethodsJson[i] as? NSDictionary {
                    let currentCustomerPaymentMethod = CustomerPaymentMethod.fromJSON(customerPaymentMethodDic)
                    customerPaymentMethods.append(currentCustomerPaymentMethod)
                }
                
            }
            pmSearch.customerOptions = customerPaymentMethods
        }
        
        var cards = [Card]()
        if let cardsJson = json["cards"] as? NSArray {
            for i in 0..<cardsJson.count {
                if let cardDic = cardsJson[i] as? NSDictionary {
                    let card = Card.fromJSON(cardDic)
                    cards.append(card)
                }
                
            }
            pmSearch.cards = cards
        }
        
        if let accountMoneyDic = json["account_money"] as? NSDictionary {
            pmSearch.accountMoney = AccountMoneyPaymentMethod.fromJSON(accountMoneyDic)
        }


        return pmSearch
    }
    
}

public func ==(obj1: PaymentMethodSearch, obj2: PaymentMethodSearch) -> Bool {
    let areEqual =
    obj1.groups == obj2.groups &&
    obj1.paymentMethods == obj2.paymentMethods
    return areEqual
}