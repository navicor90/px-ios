//
//  AppDecorationKeeper.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 2/24/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import Foundation

extension DecorationPreference {
    @nonobjc internal static var navigationControllerMemento : NavigationControllerMemento?

    
    static func saveNavBarStyleFor(navigationController: UINavigationController) {
        DecorationPreference.navigationControllerMemento = NavigationControllerMemento(navigationController: navigationController)
    }
    
    static func applyAppNavBarDecorationPreferencesTo(navigationController: UINavigationController){
        guard let navControllerMemento = DecorationPreference.navigationControllerMemento else {
            return
        }
        navigationController.navigationBar.barTintColor = navControllerMemento.navBarTintColor
        navigationController.navigationBar.titleTextAttributes = navControllerMemento.navTitleTextAttributes
        navigationController.navigationBar.tintColor = navControllerMemento.navTintColor
        navigationController.navigationBar.titleTextAttributes =  navControllerMemento.navTitleTextAttributes
        navigationController.navigationBar.isTranslucent = navControllerMemento.navIsTranslucent
        navigationController.navigationBar.backgroundColor = navControllerMemento.navBackgroundColor
        navigationController.navigationBar.restoreBottomLine()
    }
}


internal class NavigationControllerMemento {
    var navBarTintColor : UIColor?
    var navTintColor : UIColor?
    var navTitleTextAttributes : [String : Any]?
    var navIsTranslucent : Bool = false
    var navViewBackgroundColor : UIColor?
    var navBackgroundColor : UIColor?
    
    init(navigationController : UINavigationController) {
        self.navBarTintColor =  navigationController.navigationBar.barTintColor
        self.navTintColor =  navigationController.navigationBar.tintColor
        self.navTitleTextAttributes = navigationController.navigationBar.titleTextAttributes
        self.navIsTranslucent = navigationController.navigationBar.isTranslucent
        self.navViewBackgroundColor = navigationController.view.backgroundColor
        self.navBackgroundColor = navigationController.navigationBar.backgroundColor
    }
}
