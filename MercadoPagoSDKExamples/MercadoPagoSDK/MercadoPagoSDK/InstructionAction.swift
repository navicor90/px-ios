//
//  InstructionAction.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 18/2/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class InstructionAction: NSObject {

    var label: String
    var url: String
    var tag: String

    init(label: String, url: String, tag: String) {
        self.label = label
        self.url = url
        self.tag = tag
    }

    /*public class func fromJSON(json : NSDictionary) -> Instruction {}
    
    
    "label":"Ir a banca en lÃ­nea",
    "url":"http://www.banamex.com.mx",
    "tag":"link"
    
    */

}
