//
//  DecorationPreferenceTest.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 1/17/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import XCTest

class DecorationPreferenceTest: BaseTest {
    
    func testSetBaseColor(){
        let decoration = DecorationPreference()
        XCTAssertEqual(decoration.getBaseColor(), UIColor.px_blueMercadoPago())
//        decoration.setBaseColor(color: UIColor())
//        XCTAssertEqual(decoration.getBaseColor(), UIColor.px_blueMercadoPago())
        decoration.setBaseColor(color: UIColor.brown)
        XCTAssertEqual(decoration.getBaseColor(), UIColor.brown)
    }
    
    func testEnableDarkFont(){
        let decoration = DecorationPreference()
        decoration.enableDarkFont()
        XCTAssertEqual(decoration.getFontColor(), UIColor.black)
    }
    
    func testEnableLightFont(){
        let decoration = DecorationPreference()
        decoration.enableLightFont()
        XCTAssertEqual(decoration.getFontColor(), UIColor.white)
    }
    
    func testSetMercadoPagoBaseColor(){
        let decoration = DecorationPreference()
        decoration.setMercadoPagoBaseColor()
        XCTAssertEqual(decoration.getBaseColor(), UIColor.px_blueMercadoPago())
        decoration.setBaseColor(color: UIColor.purple)
        decoration.setMercadoPagoBaseColor()
        XCTAssertEqual(decoration.getBaseColor(), UIColor.px_blueMercadoPago())
    }
    func testSetBaseColorHexa(){
        let decoration = DecorationPreference()
        decoration.setBaseColor(hexColor: "#B34C42")
        XCTAssertEqual(decoration.getBaseColor(), UIColor.errorCellColor())
    }
    func testSetMercadoPagoFont(){
        let decoration = DecorationPreference()
        decoration.setCustomFontWithName(fontName: "sarasa")
        decoration.setMercadoPagoFont()
        XCTAssertEqual(decoration.getFontName(), ".SFUIDisplay-Regular")
    }
    
    func testSetFontName(){
        let decoration = DecorationPreference()
        XCTAssertEqual(decoration.getFontName(), ".SFUIDisplay-Regular")
        decoration.setCustomFontWithName(fontName: "Comic")
        XCTAssertEqual(decoration.getFontName(), "Comic")
    }
    
}
