//
//  MPFlowBuilder.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 1/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import Foundation
import UIKit

open class MPFlowBuilder : NSObject {
    
    @available(*, deprecated: 2.0.0, message: "Use startCheckoutViewController instead")
    open class func startVaultViewController(_ amount: Double, paymentPreference : PaymentPreference? = nil,
                                             callback: @escaping (_ paymentMethod: PaymentMethod, _ tokenId: String?, _ issuer: Issuer?, _ installments: Int) -> Void) -> VaultViewController {
        MercadoPagoContext.initFlavor3()
        return VaultViewController(amount: amount, paymentPreference: paymentPreference, callback: callback)
        
    }
    
    open class func startCheckoutViewController(_ preferenceId: String,
                                                navigationController : UINavigationController,
                                                callback: @escaping (Payment) -> Void,
                                                callbackCancel : ((Void) -> Void)? = nil) {// -> UINavigationController {
        
        MercadoPagoContext.initFlavor3()
        
        let flowConfigure = FlowConfigure(navigationController: navigationController, parent: nil)
        let viewModel = CheckoutViewModel()
        viewModel.preferenceId = preferenceId
        let flow = CheckoutFlowController(flowConfigure: flowConfigure, checkoutViewModel: viewModel)
        flow.start()
        
//        let checkoutVC = CheckoutViewController(preferenceId: preferenceId,
//                                                callback: { (payment : Payment) -> Void in callback(payment) },
//                                                callbackCancel :callbackCancel)
//        return MPFlowController.createNavigationControllerWith(checkoutVC)
    }
    
    open class func startPaymentVaultViewController(_ amount: Double, paymentPreference : PaymentPreference? = nil,
                                                    navigationController : UINavigationController,
                                                    callback: @escaping (_ paymentMethod: PaymentMethod, _ token: Token?, _ issuer: Issuer?, _ payerCost : PayerCost?) -> Void,
                                                    callbackCancel : ((Void) -> Void)? = nil) -> UINavigationController {
        
        MercadoPagoContext.initFlavor2()
        
        let paymentVaultViewModel = PaymentVaultViewModel(amount: amount, paymentPrefence: paymentPreference, callback : callback)
        let flowConfigure = FlowConfigure(navigationController: navigationController, parent: nil)
        let flow = PaymentVaultFlowController(flowConfigure: flowConfigure, paymentVaultViewModel: paymentVaultViewModel)
        flow.start()
        return flow.flowConfigure.navigationController!
        
        
        /*let paymentVault = PaymentVaultViewController(amount: amount, paymentPreference : paymentPreference, callback: callback, callbackCancel: callbackCancel)
        if let callbackCancel = callbackCancel{
            paymentVault.callbackCancel = {(Void) -> Void in
            paymentVault.dismiss(animated: true, completion: { callbackCancel()}
            )}
        }
        paymentVault.viewModel.callback = {(paymentMethod: PaymentMethod, token: Token?, issuer: Issuer?, payerCost : PayerCost?) -> Void in
            paymentVault.dismiss(animated: true, completion: { () -> Void in
                callback(paymentMethod, token, issuer, payerCost)}
            )}
        paymentVault.modalTransitionStyle = .crossDissolve
        
        ErrorViewController.defaultErrorCancel = callbackCancel
        
        return MPFlowController.createNavigationControllerWith(paymentVault)*/
    }
    
    
    open class func startPaymentVaultViewController(_ amount : Double, paymentPreference : PaymentPreference? = nil, paymentMethodSearch : PaymentMethodSearch, navigationController : UINavigationController,
                                                    callback: @escaping (_ paymentMethod: PaymentMethod, _ token: Token?, _ issuer: Issuer?, _ payerCost: PayerCost?) -> Void, callbackCancel : ((Void) -> Void)? = nil) {//-> UINavigationController {
        MercadoPagoContext.initFlavor2()
        
        let paymentVaultViewModel = PaymentVaultViewModel(amount: amount, paymentPrefence: paymentPreference,
                                                        callback: callback)
        
        let flowConfigure = FlowConfigure(navigationController: navigationController, parent: nil)
        let paymentVaultFlow = PaymentVaultFlowController(flowConfigure: flowConfigure, paymentVaultViewModel: paymentVaultViewModel)
        paymentVaultFlow.start()
        
//        var paymentVault : PaymentVaultViewController?
//        paymentVault = PaymentVaultViewController(amount: amount, paymentPreference: paymentPreference, paymentMethodSearch: paymentMethodSearch, callback: {(paymentMethod: PaymentMethod, token: Token?, issuer: Issuer?, payerCost : PayerCost?) -> Void in
//            paymentVault!.dismiss(animated: true, completion: { () -> Void in
//                callback(paymentMethod, token, issuer, payerCost)}
//            )}, callbackCancel: callbackCancel)
//        if let callbackCancel = callbackCancel{
//            paymentVault?.callbackCancel = {(Void) -> Void in
//                paymentVault?.dismiss(animated: true, completion: { callbackCancel()}
//                )}
//        }
//        paymentVault!.modalTransitionStyle = .crossDissolve
//        return MPFlowController.createNavigationControllerWith(paymentVault!)
    }
    
    internal class func startPaymentVaultInCheckout(_ amount: Double, paymentPreference: PaymentPreference?, paymentMethodSearch : PaymentMethodSearch,
                                                    navigationController : UINavigationController,
                                                    callback: @escaping (_ paymentMethod: PaymentMethod, _ token: Token?, _ issuer: Issuer?, _ payerCost : PayerCost?) -> Void,
                                                    callbackCancel : ((Void) -> Void)? = nil) {
        
        MercadoPagoContext.initFlavor2()
        
        let paymentVaultViewModel = PaymentVaultViewModel(amount : amount, paymentPrefence: paymentPreference, paymentMethodSearch: paymentMethodSearch, callback: callback)
        // should have parent
        let flowConfigure = FlowConfigure(navigationController: navigationController, parent: nil)
        let flow = PaymentVaultFlowController(flowConfigure: flowConfigure, paymentVaultViewModel: paymentVaultViewModel)
        flow.start()
        
//        let paymentVault =
//            PaymentVaultViewController(amount: amount, paymentPreference: paymentPreference, paymentMethodSearch: paymentMethodSearch, tintColor: true,
//                                                      callback: callback, callbackCancel : callbackCancel)
//        paymentVault.modalTransitionStyle = .crossDissolve
//        return MPFlowController.createNavigationControllerWith(paymentVault)
    }
    
    
    open class func startCardFlow(_ paymentPreference: PaymentPreference? = nil, amount: Double, cardInformation : CardInformation? = nil, paymentMethods : [PaymentMethod]? = nil, token: Token? = nil,
                                  navigationController : UINavigationController,
                                  callback: @escaping (_ paymentMethod: PaymentMethod, _ token: Token? ,  _ issuer: Issuer?, _ payerCost: PayerCost?) -> Void, callbackCancel : ((Void) -> Void)? = nil) {
        MercadoPagoContext.initFlavor2()

        let cardViewModel = CardViewModelManager(amount: amount, paymentMethods: paymentMethods, customerCard: cardInformation, token: token, paymentSettings: paymentPreference)
        if (cardInformation == nil){
            startDefaultCardFlow(navigationController: navigationController, cardViewModel: cardViewModel, callback: callback, callbackCancel : callbackCancel)
        }else{
            startCustomerCardFlow(navigationController: navigationController, cardViewModel: cardViewModel, callback: callback, callbackCancel : callbackCancel)
        }
    }
    
    
    class func startDefaultCardFlow(navigationController : UINavigationController, cardViewModel : CardViewModelManager,
                                         callback: @escaping (_ paymentMethod: PaymentMethod, _ token: Token? ,  _ issuer: Issuer?, _ payerCost: PayerCost?) -> Void,
                                         callbackCancel : ((Void) -> Void)? = nil) {
        MercadoPagoContext.initFlavor2()
        
//        var cardVC : UINavigationController?
//        
//        var ccf : CardFormViewController = CardFormViewController()
//        
//        var currentCallbackCancel : ((Void) -> Void)
//        if (callbackCancel == nil){
//            currentCallbackCancel = { cardVC?.dismiss(animated: true, completion: { () -> Void in })}
//        } else {
//            currentCallbackCancel = callbackCancel!
//        }
      
        let flowConfigure = FlowConfigure(navigationController: navigationController)
        var cardFlow : CardFormFlowController?
        cardFlow = CardFormFlowController(flowConfigure: flowConfigure, cardViewModelManager: cardViewModel,
                                          callback: {(paymentMethod : PaymentMethod, token : Token, issuer : Issuer?) -> Void in
                                           
            cardViewModel.paymentMethods = [paymentMethod]
            cardViewModel.token = token
            cardViewModel.issuer = issuer
            
            cardFlow!.state = InInstallmentsSelection()
            cardFlow!.start()
        
        }, callbackCancel: callbackCancel)
        
        
//            MPServicesBuilder.getInstallments(token!.firstSixDigit, amount: amount, issuer: Issuer, paymentMethodId: paymentMethod._id, success: { (installments) -> Void in
//                let payerCostSelected = paymentPreference?.autoSelectPayerCost(installments![0].payerCosts)
//                if(payerCostSelected == nil){ // Si tiene una sola opcion de cuotas
//                    
//                    if installments![0].payerCosts.count>1{
//                        let pcvc = MPStepBuilder.startPayerCostForm(paymentMethod, issuer: issuer, token: token!, amount:amount, paymentPreference: paymentPreference, installment:installments![0], callback: { (payerCost) -> Void in
//                            callback(paymentMethod, token!, issuer, payerCost)
//                        })
//                        
//                        pcvc.callbackCancel = currentCallbackCancel
//                        
//                        ccf.navigationController!.pushViewController(pcvc, animated: false)
//                    }else {
//                        callback(paymentMethod, token!, issuer, installments![0].payerCosts[0])
//                        
//                    }
//                    
//                }else{
//                    callback(paymentMethod, token!, issuer, payerCostSelected)
//                }
//                
//                
//            }, failure: { (error) -> Void in
//                if let nav = ccf.navigationController {
//                    nav.hideLoading()
//                }
//                
//                
//            })
//        
//        
//        }, callbackCancel: ((Void) -> Void)?)
//        
//        
//        cardVC = MPStepBuilder.startCreditCardForm(paymentPreference, amount: amount, cardInformation : cardInformation, paymentMethods : paymentMethods, token: token, navigationController : UINavigationController(), callback: { (paymentMethod, token, issuer) -> Void in
//            
//            
//            
//            
//            
//            }, callbackCancel : currentCallbackCancel)
//        
//        ccf = cardVC?.viewControllers[0] as! CardFormViewController
//        
//        
//        cardVC!.modalTransitionStyle = .crossDissolve
//        return cardVC!
        
    }
    

    
    
    
    class func startCustomerCardFlow(navigationController : UINavigationController, cardViewModel : CardViewModelManager, callback: @escaping (_ paymentMethod: PaymentMethod, _ token: Token? ,  _ issuer: Issuer?, _ payerCost: PayerCost?) -> Void, callbackCancel : ((Void) -> Void)? = nil) {
        //let mpNav =  UINavigationController()
        //var pcvc : CardAdditionalStep!
        
 
//        pcvc = MPStepBuilder.startPayerCostForm(callback: { (payerCost) -> Void in
//                let secCode = MPStepBuilder.startSecurityCodeForm(paymentMethod: cardInformation.getPaymentMethod(), cardInfo: cardInformation) { (token) in
//                    if String.isNullOrEmpty(token!.lastFourDigits) {
//                        token!.lastFourDigits = cardInformation?.getCardLastForDigits()
//                    }
//                    callback(cardInformation.getPaymentMethod(),token,cardInformation.getIssuer(),payerCost as? PayerCost)
//                }
//                pcvc.navigationController!.pushViewController(secCode, animated: true)
//            })
//        pcvc.callbackCancel = callbackCancel
//                    
//        mpNav.pushViewController(pcvc, animated: true)
        
        //return mpNav
    }
    
    

}


































