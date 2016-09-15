//
//  WebViewViewController.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 9/12/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class WebViewViewController: MercadoPagoUIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var bundle : NSBundle? = MercadoPago.getBundle()
    var clientId:String = ""
    var returnUri:String = ""
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        print(clientId)
        let url = NSURL (string: "https://auth.mercadopago.com.ar/authorization?client_id=\(clientId)&response_type=code&platform_id=mp&redirect_uri=\(returnUri)");
        let requestObj = NSURLRequest(URL: url!);
        
        webView.delegate = self
        
        webView.loadRequest(requestObj);
        
        // Do any additional setup after loading the view.
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public init(returnUri: String){
        super.init(nibName: "WebViewViewController", bundle: self.bundle)
        self.clientId = MercadoPagoContext.clientId()
        self.returnUri = returnUri
    }
    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let surl = request.URL?.absoluteString
        
        print("url: ",request.URL?.absoluteString)
        
        if surl!.rangeOfString("\(returnUri)/?code=") != nil{
            let urlArray = surl?.characters.split{$0 == "="}.map(String.init)
            let code = urlArray![(urlArray?.count)!-1]
            print("CODE ", code)
            
            MPServicesBuilder.getUserCredentials(code, redirectUri: returnUri, success: { (userCredential) in
                print(userCredential.accessToken)
                
                }, failure: { (error) in
                    
            })
            
            self.navigationController?.popToRootViewControllerAnimated(true)
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
