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

    let examples = [["title": "Nuestro Checkout", "image": "PlugNplay"],
                    ["title": "Components de UI", "image": "Puzzle"],
                    ["title": "Servicios", "image": "Ninja"]
    ]

    @IBOutlet weak var tableExamples: UITableView!

    init() {
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

            let tests = TestCheckoutExamplesViewController()
            self.navigationController?.pushViewController(tests, animated: true)

        case 1:
            //UI Components
           // let stepsExamples = StepsExamplesViewController()
          //  self.navigationController?.pushViewController(stepsExamples, animated: true)
            return
        case 2:
            //Services
            //let servicesExamples = ServicesExamplesViewController()
            //self.navigationController?.pushViewController(servicesExamples, animated: true)
            return
        default:
            break
        }
    }

}
