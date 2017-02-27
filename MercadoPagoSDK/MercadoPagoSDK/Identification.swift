//
//  Identification.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 28/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

open class Identification : NSObject {
    
    open var type : String
    open var number : String

    
    public init (type: String, number : String) {
        self.type = type
        self.number = number
    }
    
     // TODO Safe - fromJSON -> This function isn't safe return optional instead
    open class func fromJSON(_ json : NSDictionary) -> Identification? {
        guard let type = json["type"] as? String,
            let number = json["number"] as? String else{
                return nil
        }
        return Identification(type: type, number: number)
    }
    
    open func toJSONString() -> String {
        return JSONHandler.jsonCoding(self.toJSON())
    }
    
    open func toJSON() -> [String:Any] {
        let type =  self.type
        let number = self.number
        let obj:[String:Any] = [
            "type":type ,
            "number": number
        ]
        return obj
    }
}

public func ==(obj1: Identification, obj2: Identification) -> Bool {
    
    let areEqual =
        obj1.type == obj2.type &&
        obj1.number == obj2.number
    
    return areEqual
}
