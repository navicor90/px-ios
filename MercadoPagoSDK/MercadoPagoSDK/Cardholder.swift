//
//  Cardholder.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 28/12/14.
//  Copyright (c) 2014 com.mercadopago. All rights reserved.
//

import Foundation

open class Cardholder : NSObject {
    open var name : String
    open var identification : Identification?
    
 
    public init(name: String, identification : Identification? = nil) {
        self.name = name
        self.identification = identification
    }
    
    
    // TODO Safe - fromJSON -> This function isn't safe return optional instead
    
    open class func fromJSON(_ json : NSDictionary) -> Cardholder? {
        guard let name = json["name"] as? String,
            let identification = Identification.fromJSON(json["identification"]! as! NSDictionary) else { // Cuando estoy parseando un JSON quiero que venga Identification aunque sea opcional en la clase (revisar si esta ok)
            return nil
        }
        return Cardholder(name: name, identification : identification)
    }
    
    open func toJSONString() -> String {
        return JSONHandler.jsonCoding(self.toJSON())
    }
    
    open func toJSON() -> [String:Any] {
        let name = self.name
        var identificationJSON : Any = JSONHandler.null
        if let identification = self.identification {
            identificationJSON = identification.toJSON()
        }
        let obj:[String:Any] = [
            "name": name,
            "identification" : identificationJSON
        ]
        return obj
    }
}

public func ==(obj1: Cardholder, obj2: Cardholder) -> Bool {
    
    let areEqual =
    obj1.name == obj2.name &&
    obj1.identification == obj2.identification
    
    return areEqual
}
