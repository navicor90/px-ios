//
//  UserCredential.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 9/12/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class UserCredential: NSObject {
    var accessToken : String!
    var publicKey : String!
    var refreshToken : String!
    var liveMode : Bool!
    var userId : Int!
    var tokenType : String!
    var expiresIn : Int!
    var scope : String!
    
    public class func fromJSON(json : NSDictionary) -> UserCredential {
        let userCredential = UserCredential()
        
        if json["access_token"] != nil && !(json["access_token"]! is NSNull) {
            userCredential.accessToken = json["access_token"] as! String
        }
        if json["public_key"] != nil && !(json["public_key"]! is NSNull) {
            userCredential.publicKey = json["public_key"] as! String
        }
        if json["refresh_token"] != nil && !(json["refresh_token"]! is NSNull) {
            userCredential.refreshToken = json["refresh_token"] as! String
        }
        if json["live_mode"] != nil && !(json["live_mode"]! is NSNull) {
            userCredential.liveMode = json["live_mode"] as! Bool
        }
        if json["user_id"] != nil && !(json["user_id"]! is NSNull) {
            userCredential.userId = json["user_id"] as! Int
        }
        if json["token_type"] != nil && !(json["token_type"]! is NSNull) {
            userCredential.tokenType = json["token_type"] as! String
        }
        if json["expires_in"] != nil && !(json["expires_in"]! is NSNull) {
            userCredential.expiresIn = json["expires_in"] as! Int
        }
        if json["scope"] != nil && !(json["scope"]! is NSNull) {
            userCredential.scope = json["scope"] as! String
        }
        return userCredential
    }
}
