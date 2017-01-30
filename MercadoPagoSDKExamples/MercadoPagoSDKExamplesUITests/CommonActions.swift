//
//  CommonActions.swift
//  MercadoPagoSDKExamples
//
//  Created by Maria cristina rodriguez on 11/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit
import XCTest

class CommonActions: NSObject {

    class func optionCellsAvaiable(_ options: [String]) -> Bool {

        let app = XCUIApplication()
        let tables = app.tables

        let allOptionsAvailable = options.reduce(true, {$0 && (tables.staticTexts[$1].exists)})

        return allOptionsAvailable

    }
}
