//
//  POIdentificationForm.swift
//  MercadoPagoSDKExamples
//
//  Created by Demian Tejo on 7/26/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import Foundation

class POIdentificationForm: MPPageObject {

    let continuarButton = application.navigationBars.buttons["Continuar"]
    let anteriorButton = application.navigationBars.buttons["Anterior"]
    //Identification Form
    let identificationNumberField = application.textFields["Número"]

    /* Continuar & Anterior */
    func pressContinue() {
        continuarButton.tap()
    }
    func pressAnterior() -> POGuessingForm {
        anteriorButton.tap()
        return POGuessingForm()
    }

    func completeNumber(_ number: String) {
        identificationNumberField.typeText(number)
    }
    func clearNumber() {
        identificationNumberField.typeText("")
    }

    func completeNumberAndContinue(_ number: String) {
        completeNumber(number)
        pressContinue()
    }
}
