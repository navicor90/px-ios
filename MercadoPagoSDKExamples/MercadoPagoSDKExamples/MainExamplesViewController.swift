//
//  MainExamplesViewController.swift
//  MercadoPagoSDKExamples
//
//  Created by Maria cristina rodriguez on 29/6/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit
import MercadoPagoSDK

class MainExamplesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let examples = [["title" : "Nuestro Checkout".localized, "image" : "PlugNplay"],
                               ["title" : "Components de UI".localized, "image" : "Puzzle"],
                               ["title" : "Servicios".localized, "image" : "Ninja"]
                            ]

    @IBOutlet weak var tableExamples: UITableView!
    
    init(){
        super.init(nibName: "MainExamplesViewController", bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let componentCell = UINib(nibName: "ComponentTableViewCell", bundle: nil)
        
        self.tableExamples.registerNib(componentCell, forCellReuseIdentifier: "componentCell")
        
        self.tableExamples.delegate = self
        self.tableExamples.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.examples.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableExamples.dequeueReusableCellWithIdentifier("componentCell") as! ComponentTableViewCell
        cell.initializeWith(self.examples[indexPath.row]["image"]!, title: self.examples[indexPath.row]["title"]!)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableExamples.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
            MercadoPagoContext.setPublicKey(ExamplesUtils.MERCHANT_PUBLIC_KEY_TEST)
            //Checkout Example - "150216849-2af7cedc-282a-4d97-ae54-1c9f6f6a74af"
            MercadoPagoContext.setClientId("3339632528347950")
            MercadoPagoContext.setReturnURI("http://www.mercadopago.com.ar")
            let choFlow = MPFlowBuilder.startCheckoutViewController( "150216849-174f39fe-1989-48da-bb1f-142da78aad52", callback: { (payment: Payment) in
            
            })
            
            self.presentViewController(choFlow, animated: true, completion: {})
        case 1:
            //UI Components
            let stepsExamples = StepsExamplesViewController()
            self.navigationController?.pushViewController(stepsExamples, animated: true)
        case 2:
            //Services
            let servicesExamples = ServicesExamplesViewController()
            self.navigationController?.pushViewController(servicesExamples, animated: true)
            return
        default:
            break
        }
    }

    
}
