//
//  MercadoPagoUIViewController.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 3/2/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class MercadoPagoUIViewController: UIViewController {

    internal var displayPreferenceDescription = false

    override public func viewDidLoad() {
        super.viewDidLoad()

        //Create custom button with shopping cart
        var shoppingCartImage = MercadoPago.getImage("regular_payment")
        shoppingCartImage = shoppingCartImage!.imageWithRenderingMode(.AlwaysTemplate)
        let shoppingCartButton = UIBarButtonItem()
        shoppingCartButton.image = shoppingCartImage
        shoppingCartButton.title = ""
        shoppingCartButton.target = self
        shoppingCartButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = shoppingCartButton

                self.loadMPStyles()
    }
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadMPStyles()
    }

    internal func loadMPStyles() {
        //Navigation bar colors
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor().blueMercadoPago()
    }

    internal func clearMercadoPagoStyleAndGoBackAnimated() {
        self.clearMercadoPagoStyle()
        self.navigationController?.popViewControllerAnimated(true)
    }

    internal func clearMercadoPagoStyleAndGoBack() {
        self.clearMercadoPagoStyle()
        self.navigationController?.popViewControllerAnimated(false)
    }

    internal func clearMercadoPagoStyle() {
        //Navigation bar colors
        self.navigationController?.navigationBar.titleTextAttributes = nil
        self.navigationController?.navigationBar.barTintColor = nil

    }

    internal func togglePreferenceDescription(table: UITableView) {
        displayPreferenceDescription = !displayPreferenceDescription
        table.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override public func shouldAutorotate() -> Bool {
        return false
    }

    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }

}

extension UINavigationController {

    override public func shouldAutorotate() -> Bool {
        return (self.viewControllers.count > 0 && self.viewControllers.last!.shouldAutorotate())
    }

    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return self.viewControllers.last!.supportedInterfaceOrientations()
    }
}
