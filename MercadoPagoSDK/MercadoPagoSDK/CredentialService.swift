//
//  CredentialService.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 9/27/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class CredentialService: MercadoPagoService {
    public func getCredentials(url : String = "/oauth/token", method : String = "POST", public_key : String, code:String, redirectUri:String, success: (jsonResult: AnyObject?) -> Void, failure: ((error: NSError) -> Void)?) {
        self.request(url, params: "", body: public_key, method: method, success: success, failure: failure)
    }

}
