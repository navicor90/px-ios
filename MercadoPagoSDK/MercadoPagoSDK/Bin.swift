//
//  BinMask.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 6/3/15.
//  Copyright (c) 2015 com.mercadopago. All rights reserved.
//

import Foundation

open class BinMask : NSObject {
    open var exclusionPattern : String
    open var installmentsPattern : String
    open var pattern : String
    
    public init(exclusionPattern : String, installmentsPattern : String, pattern : String){
        self.exclusionPattern = exclusionPattern
        self.installmentsPattern = installmentsPattern
        self.pattern = pattern
    }
    
    // TODO Safe - fromJSON -> This function isn't safe return optional instead
    open class func fromJSON(_ json : NSDictionary) -> BinMask? {
        guard let exclusionPattern = JSONHandler.attemptParseToString(json["exclusion_pattern"]),
            let installmentsPattern = JSONHandler.attemptParseToString(json["installments_pattern"]),
            let pattern = JSONHandler.attemptParseToString(json["pattern"]) else {
            return nil
        }
        return BinMask(exclusionPattern: exclusionPattern, installmentsPattern: installmentsPattern, pattern: pattern)
    }
    
    open func toJSON() -> [String:Any] {
        let exclusionPattern = self.exclusionPattern
        let installmentsPattern  = self.installmentsPattern
        let pattern = self.pattern
        let obj:[String:Any] = [
            "pattern": pattern,
            "installmentsPattern" : installmentsPattern,
            "exclusionPattern" : exclusionPattern
            ]
        return obj
    }
    
    open func toJSONString() -> String {
        return JSONHandler.jsonCoding(self.toJSON())
    }
}


public func ==(obj1: BinMask, obj2: BinMask) -> Bool {
    var areEqual : Bool
    if ((obj1.exclusionPattern == nil) || (obj2.exclusionPattern == nil)){
        areEqual  =
            obj1.installmentsPattern == obj2.installmentsPattern &&
            obj1.pattern == obj2.pattern

    }else{
       areEqual =
        obj1.exclusionPattern == obj2.exclusionPattern &&
        obj1.installmentsPattern == obj2.installmentsPattern &&
        obj1.pattern == obj2.pattern

    }
    
    return areEqual
}
