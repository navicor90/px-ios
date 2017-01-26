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
    
    //ARGENTINA
    //let prefID = "241325285-6ac8e517-3030-48f7-b9de-91089d74255d"
    
    
    
    //PERU
    //let prefID = "240954703-79f46a7f-5f56-4f48-9640-8592d2cd1d84"
    
        //con mail y permisos
    //let prefID = "241958103-0ef22ce4-94ba-4ad0-a457-64569917360d"

    
    
    
    //URUGUAY
    //let prefID = "241113255-a6f9f812-6b92-48d0-9bb5-6f7f9f03740e"
    
        //con id
    let prefID = "241113255-fb7b6a3e-472d-48ee-9715-4795e61b70d2"
    
    
    
    //COLOMBIA
    
        // Amount = 1000
    //let prefID = "241110424-00be5088-2ad07-4e2d-bfc9-78f4bffbc3c7"
    
        // Amount = 10000
    //let prefID = "241110424-155891fe-607e-424c-b85e-fe05b67b4ad9"
    
    
    
    //VENEZUELA
    //let prefID = "241113185-a2eef4bd-ccb6-42e0-b543-12f6aab885ef"
    

    
    
    
    
    
    
    
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
        
        self.tableExamples.register(componentCell, forCellReuseIdentifier: "componentCell")
        
        self.tableExamples.delegate = self
        self.tableExamples.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.examples.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableExamples.dequeueReusableCell(withIdentifier: "componentCell") as! ComponentTableViewCell
        cell.initializeWith(self.examples[(indexPath as NSIndexPath).row]["image"]!, title: self.examples[(indexPath as NSIndexPath).row]["title"]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableExamples.deselectRow(at: indexPath, animated: true)
        switch (indexPath as NSIndexPath).row {
        case 0:
            
            
            //Checkout Example
//<<<<<<< Updated upstream
          //  let pp = PaymentPreference()
           // pp.excludedPaymentTypeIds = ["ticket", "atm", ""]
//=======
//>>>>>>> Stashed changes
            
            
            let choFlow = MPFlowBuilder.startCheckoutViewController(prefID, callback: { (payment: Payment) in
            })
            self.present(choFlow, animated: true, completion: {})
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
