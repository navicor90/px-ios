//
//  MercadoPagoService.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 5/2/15.
//  Copyright (c) 2015 com.mercadopago. All rights reserved.
//

import Foundation
import UIKit

public class MercadoPagoService: NSObject {

    var baseURL: String!
    init (baseURL: String) {
        super.init()
        self.baseURL = baseURL
    }

    public func request(uri: String, params: String?, body: AnyObject?, method: String, success: (jsonResult: AnyObject?) -> Void, failure: ((error: NSError) -> Void)?) {

        var url = baseURL + uri
        if params != nil {
            url += "?" + params!
        }

        let finalURL: NSURL = NSURL(string: url)!
        let request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = finalURL
        request.HTTPMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if body != nil {
            request.HTTPBody = (body as! NSString).dataUsingEncoding(NSUTF8StringEncoding)
        }

		UIApplication.sharedApplication().networkActivityIndicatorVisible = true

		NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (_, data: NSData?, error: NSError?) in
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
				if error == nil {
					do {
						success(jsonResult: try NSJSONSerialization.JSONObjectWithData(data!,
							options:NSJSONReadingOptions.MutableContainers))
					} catch {
						let e: NSError = NSError(domain: "com.mercadopago.sdk", code: 1, userInfo: nil)
						failure!(error: e)
					}
                } else {
                    if failure != nil {
                        failure!(error: error!)
                    }
                }
        }
    }
}
