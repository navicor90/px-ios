//
//  CheckoutFlowController.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 1/19/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

class CheckoutFlowController: FlowController, CheckoutFlowDelegate {
    
    var checkoutViewModel : CheckoutViewModel!
    
    init(flowConfigure : FlowConfigure, checkoutViewModel : CheckoutViewModel) {
        super.init(flowConfigure: flowConfigure)
        self.checkoutViewModel = checkoutViewModel
        self.state = LoadingPreferenceState(checkoutViewModel: checkoutViewModel)
    }
    
    required init(flowConfigure: FlowConfigure) {
        fatalError("init(flowConfigure:) has not been implemented")
    }
    
    internal func startPaymentVault(animated : Bool = false){
        
        flowConfigure.parent = self
        let paymentVaultViewModel = PaymentVaultViewModel(amount: checkoutViewModel.getAmount(), paymentPrefence: checkoutViewModel.getPaymentPreference(), callback: { (paymentMethod, token, issuer, payerCost) in
        
            self.paymentVaultCallback(paymentMethod, token: token, issuer: issuer, payerCost: payerCost)
        })
        //        var callbackCancel : ((Void) -> Void)
        //
        //        // Set action for cancel callback
        //        if self.viewModel.paymentMethod == nil {
        //            callbackCancel = { Void -> Void in
        //                self.callbackCancel!()
        //            }
        //        } else {
        //            callbackCancel = { Void -> Void in
        //                self.navigationController!.popViewController(animated: true)
        //            }
        //        }
        //
        //        (paymentVaultVC.viewControllers[0] as! PaymentVaultViewController).callbackCancel = callbackCancel
        //        self.navigationController?.pushViewController(paymentVaultVC.viewControllers[0], animated: animated)
        
        
        let paymentFlow = PaymentVaultFlowController(flowConfigure: flowConfigure, paymentVaultViewModel: paymentVaultViewModel)
        paymentFlow.start()
        
    }
    
    func startRecoverCard(){
        MPServicesBuilder.getPaymentMethods({ (paymentMethods) in
//            let cardFlow = MPFlowBuilder.startCardFlow(amount: self.checkoutViewModel.getAmount(), cardInformation : nil,
//                                                       navigationController : self.flowConfigure.navigationController!,
//                                                       callback: { (paymentMethod, token, issuer, payerCost) in
//                self.paymentVaultCallback(paymentMethod, token : token, issuer : issuer, payerCost : payerCost, animated : true)
//            }, callbackCancel: {
////                self.flowConfigure.navigationController!.popToViewController(self, animated: true)
//                self.flowConfigure.popToFlowRootController(animated: true)
//            })
//            self.flowConfigure.navigationController!.pushViewController(cardFlow.viewControllers[0], animated: true)
        }) { (error) in
//            
        }
    }
    
    func startAuthCard(_ token:Token ) {
        
        let vc = MPStepBuilder.startSecurityCodeForm(paymentMethod: self.checkoutViewModel.paymentMethod!, cardInfo: token) { (token) in
            self.checkoutViewModel.token = token
            self.flowConfigure.popToFlowRootController(animated: true)
        }
        
        self.flowConfigure.navigationController?.pushViewController(vc, animated: true)
        
    }

    func paymentVaultCallback(_ paymentMethod : PaymentMethod, token : Token?, issuer : Issuer?, payerCost : PayerCost?, animated : Bool = true){
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        self.flowConfigure.navigationController!.view.layer.add(transition, forKey: nil)
        self.flowConfigure.navigationController!.popToRootViewController(animated: true)
        
        
        self.checkoutViewModel.paymentMethod = paymentMethod
        self.checkoutViewModel.token = token
        if (issuer != nil){
            self.checkoutViewModel.issuer = issuer
        }
        
        self.checkoutViewModel.payerCost = payerCost
        //self.hideLoading()
        
    }
    
}

class LoadingPreferenceState : State {

    var checkoutViewModel : CheckoutViewModel!
    
    init(checkoutViewModel : CheckoutViewModel) {
        super.init()
        self.checkoutViewModel = checkoutViewModel
    }
    
    override func nextStep(flowController: FlowController) -> UIViewController {
        
        
        if !checkoutViewModel.isPreferenceLoaded() {
            MPServicesBuilder.getPreference(checkoutViewModel.preferenceId, success: { (checkoutPreference : CheckoutPreference) in
                //self.checkoutViewModel.preference = checkoutPreference
                return self.createPaymentVaultFlow(flowController)
            }, failure: { (error) in
                
            })
        }
        
        return self.createPaymentVaultFlow(flowController)
        
    }
    
    
    private func createPaymentVaultFlow(_ flowController : FlowController) -> UIViewController {
        let paymentVaultViewModel = PaymentVaultViewModel(amount: checkoutViewModel.getAmount(), paymentPrefence: checkoutViewModel.getPaymentPreference(), callback: { (paymentMethod, token, issuer, payerCost) in
            self.checkoutViewModel.updatePaymentData(paymentMethod: paymentMethod, token: token, issuer: issuer, payerCost: payerCost)
            (flowController as! CheckoutFlowDelegate).paymentVaultCallback(self.checkoutViewModel.paymentMethod!, token: self.checkoutViewModel.token, issuer: self.checkoutViewModel.issuer, payerCost: self.checkoutViewModel.payerCost, animated: true)
            
            flowController.state = InReviewAndConfirmState(checkoutViewModel: self.checkoutViewModel)
            let vc = flowController.state!.nextStep(flowController: flowController)
            flowController.flowConfigure.navigationController?.pushViewController(vc, animated: true)
            
        })
        
        let paymentVaultFlowConfig = FlowConfigure(navigationController: flowController.flowConfigure.navigationController, parent: flowController)
        let paymentVaultFlow = PaymentVaultFlowController(flowConfigure: paymentVaultFlowConfig, paymentVaultViewModel: paymentVaultViewModel)
        
        let paymentVaultVc = PaymentVaultViewController(paymentVaultViewModel: paymentVaultViewModel)
        paymentVaultVc.delegate = paymentVaultFlow
        return paymentVaultVc

    
    }
    
}

class InReviewAndConfirmState : State {
    
    var checkoutViewModel : CheckoutViewModel!
    
    init(checkoutViewModel : CheckoutViewModel) {
        super.init()
        self.checkoutViewModel = checkoutViewModel
    }
    
    override func nextStep(flowController: FlowController) -> UIViewController {
        let vc = CheckoutViewController(preferenceId: "preferenceId", callback: checkoutViewModel.callback)
        
        
        return vc
    }
}


protocol CheckoutFlowDelegate {


    func startPaymentVault(animated : Bool)
    
    func startRecoverCard()
    
    func startAuthCard(_ token:Token )
    
    func paymentVaultCallback(_ paymentMethod : PaymentMethod, token : Token?, issuer : Issuer?, payerCost : PayerCost?, animated : Bool)
}
