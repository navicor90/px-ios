//
//  CardInformation.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 12/8/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

@objc
public protocol CustomerInformation : NSObjectProtocol {
    
    func isSecurityCodeRequired() -> Bool
    
    func getId() -> String
    
    func getDescription() -> String
    
    func getPaymentMethod() -> PaymentMethod
    
    func getPaymentMethodId() -> String
    
    func getPaymentTypeId() -> String
    
    func setupPaymentMethod(paymentMethod : PaymentMethod)
    
    func getLastFourDigits() -> String
    
}

