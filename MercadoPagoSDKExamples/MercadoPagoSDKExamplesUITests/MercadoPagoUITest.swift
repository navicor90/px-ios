//
//  MercadoPagoUITest.swift
//  MercadoPagoSDKExamples
//
//  Created by Demian Tejo on 7/13/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import XCTest

open class MercadoPagoUITest: XCTestCase {

    var arguments: [String] = ["UITestingEnabled"]
    static var sharedApplication =  XCUIApplication()
    static var initializedApplication = false
    static var application: XCUIApplication =  MercadoPagoUITest.sharedApplication
    var cardsTestArray: [TestCard]?

    //DEMO
    var cardsForDemo: [TestCard]?
    var rejected: [TestCard]?
    override open func setUp() {
        super.setUp()
        cardsTestArray = [visaGaliciaII(), amexI(), amexII(), amexIII(), amexIV(), amexMacro(), visaNaranja(), tarshop(), tarshopWithoutCVV(), amexPatagonia(), visaPatagonia(), visaHipotecario(), naranja(), naranjaMaster(), cencosud(), master(), argencard(), cargencardII(), cabal(), visaGoldSantander(), nativa(), masterPatagonia(), visaPatagoniaII(), masterItau(), diners(), masterII(), visaNacion(), masterNacion(), visaIndustrial(), masterIndustrial(), visaProvincia(), masterProvincia(), masterCencosud(), cordial(), cordialII(), cordialIII(), cmr(), cordobesa(), visaGalicia(), visaNaranjaII(), visaGaliciaGold()]

        cardsForDemo = [cabal(), naranja(), tarshopWithoutCVV(), diners(), cordial()]
        rejected = [mercadopago()]
        continueAfterFailure = false
        if(!MercadoPagoUITest.initializedApplication) {
            MercadoPagoUITest.initializedApplication = true
            MercadoPagoUITest.sharedApplication.launchArguments = arguments
            MercadoPagoUITest.sharedApplication.launch()
        }

    }

    internal func randomTestCard() -> TestCard {
        let randomIndex = Int(arc4random_uniform(UInt32(cardsTestArray!.count)))

        return cardsTestArray![randomIndex]
    }

    override open func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func approvedUser() -> TestUser {
        let user = TestUser()
        user.name = "APRO"
        user.identification.number = "12123123"
        user.identification.type = "DNI"
        return user
    }

     func visaGalicia() -> TestCard {
     let card = TestCard()
     card.name = "Visa Galicia"
     card.number = "4170068810108020"
     card.cvv = "123"
     return card
     }

     func visaGaliciaII() -> TestCard {
     let card = TestCard()
     card.name = "Visa Galicia II"
     card.number = "4544610257481730"
     card.cvv = "123"
     return card
     }

     func visaGaliciaGold() -> TestCard {
     let card = TestCard()
     card.name = "Visa Galicia Gold"
     card.number = "4433820255583262"
     card.cvv = "123"
     return card
     }

     func amexI() -> TestCard {
     let card = TestCard()
     card.name = "Amex I"
     card.number = "371180303257522"
     card.cvv = "1234"
     return card
     }

     func amexII() -> TestCard {
     let card = TestCard()
     card.name = "Amex II"
     card.number = "378318374262624"
     card.cvv = "1234"
     return card
     }

     func amexIII() -> TestCard {
     let card = TestCard()
     card.name = "Amex III"
     card.number = "370284003380856"
     card.cvv = "1234"
     return card
     }

     func amexIV() -> TestCard {
     let card = TestCard()
     card.name = "Amex IV"
     card.number = "376637784717865"
     card.cvv = "1234"
     return card
     }

     func amexMacro() -> TestCard {
     let card = TestCard()
     card.name = "Amex (macro)"
     card.number = "371594625346344"
     card.cvv = "1234"
     return card
     }

     func visaNaranja() -> TestCard {
     let card = TestCard()
     card.name = "Naranja Visa"
     card.number = "4029188705767814"
     card.cvv = "123"
     return card
     }

     func visaNaranjaII() -> TestCard {
     let card = TestCard()
     card.name = "Naranja Visa II"
     card.number = "4029175038638341"
     card.cvv = "123"
     return card
     }

     func tarshop() -> TestCard {
     let card = TestCard()
     card.name = "Tarshop 16 digitos"
     card.number = "6034880000944555"
     card.cvv = "123"
     return card
     }

     func tarshopWithoutCVV() -> TestCard {
     let card = TestCard()
     card.name = "Tarshop 13 digitos (without CVV)"
     card.number = "2799519076121"
     return card
     }

     func amexPatagonia() -> TestCard {
     let card = TestCard()
     card.name = "Amex Patagonia"
     card.number = "376713152830588"
     card.cvv = "1234"
     return card
     }

     func visaPatagonia() -> TestCard {
     let card = TestCard()
     card.name = "Visa Patagonia"
     card.number = "4508336715544174"
     card.cvv = "123"
     return card
     }

     func visaHipotecario() -> TestCard {
     let card = TestCard()
     card.name = "Visa Hipotecario"
     card.number = "4304953822223405"
     card.cvv = "123"
     return card
     }

     func naranja() -> TestCard {
     let card = TestCard()
     card.name = "Naranja"
     card.number = "5895627823453005"
     card.cvv = "123"
     return card
     }

     func naranjaMaster() -> TestCard {
     let card = TestCard()
     card.name = "Naranja Master"
     card.number = "5275715457287506"
     card.cvv = "123"
     return card
     }

     func cencosud() -> TestCard {
     let card = TestCard()
     card.name = "Cencosud"
     card.number = "6034937272862830"
     card.cvv = "123"
     return card
     }

     func master() -> TestCard {
     let card = TestCard()
     card.name = "Master"
     card.number = "5031755734530604"
     card.cvv = "123"
     return card
     }

     func argencard() -> TestCard {
     let card = TestCard()
     card.name = "Argencard"
     card.number = "5031755734530604"
     card.cvv = "123"
     return card
     }

     func cargencardII() -> TestCard {
     let card = TestCard()
     card.name = "Argencard II"
     card.number = "5011054211206753"
     card.cvv = "123"
     return card
     }

     func cabal() -> TestCard {
     let card = TestCard()
     card.name = "Cabal"
     card.number = "6035227716427021"
     card.cvv = "123"
     return card
     }

     func visaGoldSantander() -> TestCard {
     let card = TestCard()
     card.name = "Visa Gold Santander"
     card.number = "4509953566233704"
     card.cvv = "123"
     return card
     }

     func nativa() -> TestCard {
     let card = TestCard()
     card.name = "Nativa"
     card.number = "5465532683840176"
     card.cvv = "123"
     return card
     }

     func masterPatagonia() -> TestCard {
     let card = TestCard()
     card.name = "Master Patagonia"
     card.number = "5156883002652543"
     card.cvv = "123"
     return card
     }

     func visaPatagoniaII() -> TestCard {
     let card = TestCard()
     card.name = "Visa Patagonia II"
     card.number = "4937704771151724"
     card.cvv = "123"
     return card
     }

     func masterItau() -> TestCard {
     let card = TestCard()
     card.name = "Master Itau"
     card.number = "5254557630464783"
     card.cvv = "123"
     return card
     }

     func diners() -> TestCard {
     let card = TestCard()
     card.name = "Diners"
     card.number = "30238030180020"
     card.cvv = "123"
     return card
     }

     func masterII() -> TestCard {
     let card = TestCard()
     card.name = "Master II"
     card.number = "5323793735506106"
     card.cvv = "123"
     return card
     }

     func visaNacion() -> TestCard {
     let card = TestCard()
     card.name = "Nacion Visa"
     card.number = "4793757064546557"
     card.cvv = "123"
     return card
     }

     func masterNacion() -> TestCard {
     let card = TestCard()
     card.name = "Nacion Master"
     card.number = "5353237570807727"
     card.cvv = "123"
     return card
     }

     func visaIndustrial() -> TestCard {
     let card = TestCard()
     card.name = "Industrial Visa"
     card.number = "4565643316823786"
     card.cvv = "123"
     return card
     }

     func masterIndustrial() -> TestCard {
     let card = TestCard()
     card.name = "Industrial Master"
     card.number = "5536744620435276"
     card.cvv = "123"
     return card
     }

     func visaProvincia() -> TestCard {
     let card = TestCard()
     card.name = "Provincia Visa"
     card.number = "4893217740471661"
     card.cvv = "123"
     return card
     }

     func masterProvincia() -> TestCard {
     let card = TestCard()
     card.name = "Provincia Master"
     card.number = "5276130574852647"
     card.cvv = "123"
     return card
     }

     func masterCencosud() -> TestCard {
     let card = TestCard()
     card.name = "Cencosud  Master"
     card.number = "5271045635717131"
     card.cvv = "123"
     return card
     }

     func cordial() -> TestCard {
     let card = TestCard()
     card.name = "Cordial"
     card.number = "5221352856430472"
     card.cvv = "123"
     return card
     }

     func cordialII() -> TestCard {
     let card = TestCard()
     card.name = "Cordial II"
     card.number = "5221373755675074"
     card.cvv = "123"
     return card
     }

     func cordialIII() -> TestCard {
     let card = TestCard()
     card.name = "Cordial III"
     card.number = "5275552613640256"
     card.cvv = "123"
     return card
     }

     func cmr() -> TestCard {
     let card = TestCard()
     card.name = "CMR"
     card.number = "5570390633007137"
     card.cvv = "123"
     return card
     }

     func cordobesa() -> TestCard {
     let card = TestCard()
     card.name = "Cordobesa"
     card.number = "5500732058068364"
     card.cvv = "123"
     return card
     }

     func mercadopago() -> TestCard {
     let card = TestCard()
     card.name = "Tarjeta Mercado Pago"
     card.number = "5150730431208304"
     card.cvv = "123"
     return card
     }

     /*
     coming soon
     func visa() -> TestCard {
     let card = TestCard()
     card.name = "Nevada"
     card.number = ".........."
     card.cvv = "123"
     return card
     }
     */

}

class TestCard: NSObject {

    var name: String = ""
    var number: String = ""
    var cvv: String?
    var expirationDate: String = "1122"

}

class TestUser: NSObject {

    var name: String = ""
    var identification: TestIdentification = TestIdentification()

}

class TestIdentification: NSObject {

    var type: String = ""
    var number: String = ""
}
