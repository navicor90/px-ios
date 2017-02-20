//
//  PaymentResultScreenPreference.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 2/14/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import Foundation

open class PaymentResultScreenPreference: NSObject {
    
    var approvedTitle = "¡Listo, se acreditó tu pago!".localized
    var approvedSubtitle = ""
    var pendingTitle = "Estamos procesando el pago".localized
    var pendingSubtitle = ""
    var contentTitle = "¿Qué puedo hacer?".localized
    var contentText = ""
    var exitButttonTitle = "Continuar".localized
    var headerPendingIconName = "iconoAcreditado"
    var headerPendingIconBundle = MercadoPago.getBundle()!
    var disableSelectAnotherPaymentMethod = false
    
    internal static var pendingAdditionalInfoCells = [MPCustomCell]()
    internal static var approvedAdditionalInfoCells = [MPCustomCell]()
    
    open func setAppovedTitle(title: String) {
        self.approvedTitle = title
    }
    
    open func setAppovedSubtitle(subtitle: String) {
        self.approvedSubtitle = subtitle
    }
    
    open func setPendingTitle(title: String) {
        self.pendingTitle = title
    }
    
    open func setPendingSubtitle(subtitle: String) {
        self.pendingSubtitle = subtitle
    }
    
    open func setExitButtonTitle(title: String) {
        self.exitButttonTitle = title
    }
    
    open func setPendingHeaderIcon(name: String, bundle: Bundle) {
        self.headerPendingIconName = name
        self.headerPendingIconBundle = bundle
    }
    
    open func disableChangePaymentMethodOption(){
        self.disableSelectAnotherPaymentMethod = true
    }
    
    open func enableChangePaymentMethodOption(){
        self.disableSelectAnotherPaymentMethod = false
    }
    
    open static func addCustomPendingCell(customCell : MPCustomCell) {
        PaymentResultScreenPreference.pendingAdditionalInfoCells.append(customCell)
    }
    
    open static func addCustomApprovedCell(customCell : MPCustomCell) {
        PaymentResultScreenPreference.approvedAdditionalInfoCells.append(customCell)
    }
    
    open static func clear() {
        PaymentResultScreenPreference.approvedAdditionalInfoCells = [MPCustomCell]()
        PaymentResultScreenPreference.pendingAdditionalInfoCells = [MPCustomCell]()
    }
    
    open func setContentText(text: String){
        self.contentText = text
    }
    
    open func setContentTitle(title: String){
        self.contentTitle = title
    }
    
    open func getApprovedTitle() -> String {
        return approvedTitle
    }
    
    open func getApprovedSubtitle() -> String {
        return approvedSubtitle
    }
    
    open func getPendingTitle() -> String {
        return pendingTitle
    }
    
    open func getPendingSubtitle() -> String {
        return pendingSubtitle
    }
    
    open func getExitButtonTitle() -> String {
        return exitButttonTitle
    }
    
    open func getHeaderPendingIcon() -> UIImage? {
        return MercadoPago.getImage(headerPendingIconName, bundle: headerPendingIconBundle)
    }
    
    open func isSelectAnotherPaymentMethodDisable() -> Bool {
        return disableSelectAnotherPaymentMethod
    }
    
    open func getContetTitle() -> String {
        return contentTitle
    }
    
    open func getContentText() -> String {
        return contentText
    }
}
