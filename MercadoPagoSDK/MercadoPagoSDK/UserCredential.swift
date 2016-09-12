//
//  UserCredential.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 9/12/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class UserCredential: NSObject {
    var accessToken : String!
    var publicKey : String!
    var refreshToken : String!
    var liveMode : Bool!
    var userId : Int!
    var tokenType : String!
    var expiresIn : Int!
    var scope : String!

}
