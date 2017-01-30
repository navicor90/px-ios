//
//  Address.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 31/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

public class Address: NSObject {
    public var streetName: String?
    public var streetNumber: NSNumber?
    public var zipCode: String?

    public override init () {
                super.init()
    }

    public init (streetName: String?, streetNumber: NSNumber?, zipCode: String?) {
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.zipCode = zipCode
    }

    public class func fromJSON(json: NSDictionary) -> Address {
        let address: Address = Address()
        address.streetName = JSON(json["street_name"]!).asString
        if json["street_number"] != nil && !(json["street_number"]! is NSNull) {
			address.streetNumber = NSNumber(longLong: (json["street_number"] as? NSString)!.longLongValue)
        }
        address.zipCode = JSON(json["zip_code"]!).asString
        return address
    }
}
