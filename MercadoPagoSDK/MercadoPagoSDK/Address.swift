//
//  Address.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 31/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

open class Address : Equatable {
    open var streetName : String
    open var streetNumber : NSNumber
    open var zipCode : String
    

    public init (streetName: String, streetNumber: NSNumber, zipCode : String) {
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.zipCode = zipCode
    }
    
    // TODO Safe - fromJSON -> This function isn't safe return optional instead
    open class func fromJSON(_ json : NSDictionary) -> Address? {
        guard let streetName = JSONHandler.attemptParseToString(json["street_name"]) ,
              let streetNumber = JSONHandler.attemptParseToString(json["street_number"])?.numberValue ,
              let zipCode = JSONHandler.attemptParseToString(json["zip_code"]) else {
           
            return nil
        }
        
        return Address(streetName: streetName, streetNumber: streetNumber, zipCode: zipCode)
    }
}

public func ==(obj1: Address, obj2: Address) -> Bool {
    
    let areEqual =
        obj1.streetName == obj2.streetName &&
        obj1.streetNumber == obj2.streetNumber &&
        obj1.zipCode == obj2.zipCode
   
    return areEqual
}
