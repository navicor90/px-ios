//
//  DecorationPreference.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 1/16/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import Foundation

open class DecorationPreference : NSObject{
    var baseColor: UIColor = UIColor.px_blueMercadoPago()
    var textColor: UIColor = UIColor.white
    var fontName: String = ".SFUIDisplay-Regular"
    
    public func setBaseColor(color: UIColor){
        baseColor = color
    }
    public func enableDarkFont(){
        textColor = UIColor.black
    }
    public func enableLightFont(){
        textColor = UIColor.white
    }
    public func setFontWithName(fontName: String){
        self.fontName = fontName
    }
    public func setMercadoPagoBaseColor(){
        baseColor = UIColor.px_blueMercadoPago()
    }
    public func setMercadoPagoFont(){
        fontName = ".SFUIDisplay-Regular"
    }
    public func getBaseColor() -> UIColor {
        return baseColor
    }
    public func getFontColor() -> UIColor {
        return textColor
    }
    public func getFontName() -> String {
        return fontName
    }
}
