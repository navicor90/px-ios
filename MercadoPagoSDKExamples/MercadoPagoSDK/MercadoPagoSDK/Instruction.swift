//
//  Instruction.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 18/2/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class Instruction: NSObject {

    var title: String!
    var accreditationMessage: String!
    var references: [InstructionReference]!
    var info: [String]!
    var secondaryInfo: [String]?
    var tertiaryInfo: [String]?
    var actions: [InstructionAction]?

    public class func fromJSON(json: NSDictionary) -> Instruction {
        let instruction = Instruction()
        if json["title"] != nil && !(json["title"]! is NSNull) {
            instruction.title = (json["title"]! as? String)!
        }

        if json["accreditation_message"] != nil && !(json["accreditation_message"]! is NSNull) {
            instruction.accreditationMessage = (json["accreditation_message"]! as? String)!
        }

        if json["references"] != nil && !(json["references"]! is NSNull) {
            instruction.references = (json["references"] as! Array).map({InstructionReference.fromJSON($0)})
        }

        if json["info"] != nil && !(json["info"]! is NSNull) {
            var info = [String]()
            for value in (json["info"] as! NSArray) {
                info.append(value as! String)
            }
            instruction.info = info
        }

        if json["secondary_info"] != nil && !(json["secondary_info"]! is NSNull) {
            var info = [String]()
            for value in (json["secondary_info"] as! NSArray) {
                info.append(value as! String)
            }
            instruction.secondaryInfo = info
        }

        if json["tertiary_info"] != nil && !(json["tertiary_info"]! is NSNull) {
            var info = [String]()
            for value in (json["tertiary_info"] as! NSArray) {
                info.append(value as! String)
            }
            instruction.tertiaryInfo = info
        }

        if json["actions"] != nil && !(json["actions"]! is NSNull) {
            //TODO parse actions
        }

        return instruction
    }
}
