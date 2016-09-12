//
//  WebViewViewController.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 9/12/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class WebViewViewController: MercadoPagoUIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL (string: "https://www.google.com.ar/#q=mercadopago");
        let requestObj = NSURLRequest(URL: url!);
        
        webView.delegate = self
        
        webView.loadRequest(requestObj);
        
        // Do any additional setup after loading the view.
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let surl = request.URL?.absoluteString
        
        if  surl ==  "https://www.mercadopago.com.ar/"{
            print("Mercado Pago")
            self.navigationController?.popToRootViewControllerAnimated(true)
            
            return false
            
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
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
