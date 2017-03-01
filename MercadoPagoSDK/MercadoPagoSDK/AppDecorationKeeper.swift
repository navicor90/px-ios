//
//  AppDecorationKeeper.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 2/24/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import Foundation

extension DecorationPreference {
    @nonobjc internal static var appNavBarTintColor : UIColor?
    @nonobjc internal static var appNavTintColor : UIColor?
    @nonobjc internal static var appNavTitleTextAttributes : [String : Any]?
    @nonobjc internal static var appNavIsTranslucent : Bool = false
    @nonobjc internal static var appNavViewBackgroundColor : UIColor?
    @nonobjc internal static var appNavBackgroundColor : UIColor?
    
    static func saveNavBarStyleFor(navigationController: UINavigationController) {
        DecorationPreference.appNavBarTintColor =  navigationController.navigationBar.barTintColor
        DecorationPreference.appNavTintColor =  navigationController.navigationBar.tintColor
        DecorationPreference.appNavTitleTextAttributes = navigationController.navigationBar.titleTextAttributes
        DecorationPreference.appNavIsTranslucent = navigationController.navigationBar.isTranslucent
        DecorationPreference.appNavViewBackgroundColor = navigationController.view.backgroundColor
        DecorationPreference.appNavBackgroundColor = navigationController.navigationBar.backgroundColor
    }
    
    static func applyAppNavBarDecorationPreferencesTo(navigationController: UINavigationController){
        navigationController.navigationBar.barTintColor = DecorationPreference.appNavBarTintColor
        navigationController.navigationBar.titleTextAttributes = DecorationPreference.appNavTitleTextAttributes
        navigationController.navigationBar.tintColor = DecorationPreference.appNavTintColor
        navigationController.navigationBar.titleTextAttributes =  DecorationPreference.appNavTitleTextAttributes
        navigationController.navigationBar.isTranslucent = DecorationPreference.appNavIsTranslucent
        navigationController.navigationBar.backgroundColor = DecorationPreference.appNavBackgroundColor
        navigationController.navigationBar.restoreBottomLine()
    }
}
