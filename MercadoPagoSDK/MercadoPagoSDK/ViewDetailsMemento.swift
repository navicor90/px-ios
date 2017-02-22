//
//  ViewDetailsMemento.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 2/20/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

class ViewDetailsMemento: NSObject {

    private var backgroundImage : UIImage?
    private var shadowImage : UIImage?
    private var tintColor : UIColor?
    private var backgroundColor : UIColor?
    private var isTranslucent : Bool?
    private var titleAttributes : NSDictionary?

    public func saveDetails(navigationController : UINavigationController) {
        //self.backgroundImage = navigationController.navigationBar.im
        self.shadowImage = navigationController.navigationBar.shadowImage
        self.tintColor = navigationController.navigationBar.tintColor
        print(self.tintColor?.cgColor)
        self.backgroundColor = navigationController.navigationBar.backgroundColor
        print(self.backgroundColor?.cgColor)
        self.isTranslucent = navigationController.navigationBar.isTranslucent
        self.titleAttributes = navigationController.navigationBar.titleTextAttributes as? NSDictionary
    }
    
    public func recoverDetails(navigationController : UINavigationController) {
        
//        if let backgroundImage = self.backgroundImage {
//            navigationController.navigationBar.setBackgroundImage(backgroundImage, for: .default)
//        }
//        
//        if let shadowImage = self.shadowImage {
//            navigationController.navigationBar.shadowImage = shadowImage
//        }
        
      //  navigationController.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
      //  navigationController.navigationBar.shadowImage = nil
             navigationController.navigationBar.tintColor = UIColor.purple
        navigationController.navigationBar.barTintColor = UIColor.purple
        if let tintColor = self.tintColor {
            //navigationController.navigationBar.tintColor = tintColor
            print(tintColor)
            navigationController.navigationBar.tintColor = UIColor.purple
            navigationController.navigationBar.barTintColor = UIColor.purple
        }
        
//        if let backgroundColor = self.backgroundColor {
//            navigationController.navigationBar.backgroundColor = backgroundColor
//            
//        }
//        
//        if let isTranslucent = self.isTranslucent {
//            navigationController.navigationBar.isTranslucent = false//isTranslucent
//        }
//        
//        if let titleAttributes = self.titleAttributes {
//            navigationController.navigationBar.titleTextAttributes = titleAttributes as! [String : Any]
//        }
        
    }
}
