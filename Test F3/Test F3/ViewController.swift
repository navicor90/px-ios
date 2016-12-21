//
//  ViewController.swift
//  Test F3
//
//  Created by AUGUSTO COLLERONE ALFONSO on 12/20/16.
//  Copyright © 2016 AUGUSTO COLLERONE ALFONSO. All rights reserved.
//

import UIKit
import MercadoPagoSDK

class ViewController: UIViewController {

    @IBOutlet weak var f3Button: UIButton!
    @IBOutlet weak var f2Button: UIButton!
    @IBOutlet weak var f1Button: UIButton!
    
    
    let prefId = "150216849-a0d75d14-af2e-4f03-bba4-d2f0ec75e301"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.f3Button.addTarget(self, action: #selector(ViewController.startCheckout),for: .touchUpInside)
        self.f2Button.addTarget(self, action: #selector(ViewController.startStepBuilder), for: .touchUpInside)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func startCheckout(){
        let checkout = MPFlowBuilder.startCheckoutViewController(prefId, callback: { (payment: Payment) in
        // Listo! El pago ya fue procesado por MP.
        // En el paso siguiente esta el metodo displayPaymentInfo
        self.displayPaymentInfo(payment: payment)
                                                                    
        }, callbackCancel: {
            // Acción a ejecutar en caso de que el usuario
            // no efectue la compra
        })
        
        self.present(checkout, animated: true,completion: {})
    }
    
    
    func startStepBuilder(){
        }
    
    
    func displayPaymentInfo(payment : Payment){
        //let paymentInfo = "id : " + String(payment._id) + "", status : " + payment.status + ", status detail : " + payment.statusDetail
        //self.paymentResult.text = paymentInfo
    }
    
    
}

