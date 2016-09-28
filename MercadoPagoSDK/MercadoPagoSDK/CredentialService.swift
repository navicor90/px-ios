//
//  CredentialService.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 9/27/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class CredentialService: MercadoPagoService {
    public func getCredentials(url : String = "", method : String = "POST", public_key : String, code:String, redirectUri:String, success: (jsonResult: AnyObject?) -> Void, failure: ((error: NSError) -> Void)?) {
        let body = "{\"code\": \"\(code)\", \"redirect_uri\": \"\(redirectUri)\"}"
        self.request(url, params: "", body: body, method: method, success: success, failure: failure)
    }

}
