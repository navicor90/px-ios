//
//  Payer.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 6/3/15.
//  Copyright (c) 2015 com.mercadopago. All rights reserved.
//

import Foundation

public class Payer: NSObject {
    public var email: String!
    public var _id: NSNumber = 0
    public var identification: Identification!
    public var type: String!

    init(_id: NSNumber, email: String, type: String, identification: Identification) {
        super.init()
        self._id = _id
        self.email = email
        self.type = type
        self.identification = identification
    }

    public override init() {
        super.init()
    }

    public class func fromJSON(json: NSDictionary) -> Payer {
        let payer: Payer = Payer()
        if json["id"] != nil && !(json["id"]! is NSNull) {
            payer._id = NSNumber(longLong: (json["id"] as? NSString)!.longLongValue)
        }
        payer.email = JSON(json["email"]!).asString
        payer.type = JSON(json["type"]!).asString
        if let identificationDic = json["identification"] as? NSDictionary {
            payer.identification = Identification.fromJSON(identificationDic)
        }
        return payer
    }

}
