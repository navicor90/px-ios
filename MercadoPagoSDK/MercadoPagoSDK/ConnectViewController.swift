//
//  ConnectViewController.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 9/27/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class ConnectViewController: MercadoPagoUIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    var bundle : NSBundle? = MercadoPago.getBundle()
    var returnUri: String = ""
    var callback: ((userCredential : UserCredential) -> Void)?

    override public func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: "https://auth.mercadopago.com.ar/authorization?client_id=\(MercadoPagoContext.clientId())&response_type=code&platform_id=mp&redirect_uri=\(MercadoPagoContext.returnURI())");
        let requestObj = NSURLRequest(URL: url!);
        
        webView.delegate = self
        
        webView.loadRequest(requestObj);
        
        // Do any additional setup after loading the view.
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public init(callback : (userCredential : UserCredential) -> Void){
        super.init(nibName: "ConnectViewController", bundle: self.bundle)
        self.returnUri = MercadoPagoContext.returnURI()
        self.callback = callback
    }
    public func webViewDidStartLoad(webView : UIWebView) {
        LoadingOverlay.shared.showOverlay(self.view, backgroundColor: UIColor(red: 217, green: 217, blue: 217), indicatorColor: UIColor.whiteColor())
    }
    public func webViewDidFinishLoad(webView: UIWebView) {
        LoadingOverlay.shared.hideOverlayView()
    }
    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let surl = request.URL?.absoluteString
        
        if surl!.rangeOfString("\(MercadoPagoContext.returnURI())/?code=") != nil{
            let urlArray = surl?.characters.split{$0 == "="}.map(String.init)
            let code = urlArray![(urlArray?.count)!-1]
            print("Code: ", code)
            MPServicesBuilder.getUserCredentials(code, redirectUri: returnUri, success: { (userCredential) in
                print("Access Token: ", userCredential.accessToken)
                
                if let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies {
                    for cookie in cookies {
                        if cookie.domain == ".mercadopago.com.ar" || cookie.domain == ".mercadolibre.com"{
                            var cookieProperties = [String: AnyObject]()
                            cookieProperties[NSHTTPCookieName] = cookie.name
                            cookieProperties[NSHTTPCookieValue] = cookie.value
                            cookieProperties[NSHTTPCookieDomain] = cookie.domain
                            cookieProperties[NSHTTPCookiePath] = cookie.path
                            cookieProperties[NSHTTPCookieVersion] = NSNumber(integer: cookie.version)
                            cookieProperties[NSHTTPCookieExpires] = cookie.expiresDate
                            cookieProperties[NSHTTPCookieDiscard] = true
                            
                            NSHTTPCookieStorage.sharedHTTPCookieStorage().deleteCookie(cookie)
                            let newCookie = NSHTTPCookie(properties: cookieProperties)
                            NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(newCookie!)
                        }
                        
                    }
                }
                
                self.callback!(userCredential: userCredential)
                
                self.navigationController?.popViewControllerAnimated(true);
                
                }, failure: { (error) in
                    
            })
            
            return false
            
        }
        
        return true
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
