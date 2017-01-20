//
//  PaymentVaultFlowController.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 1/18/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

class PaymentVaultFlowController: FlowController, PaymentMethodSelectedDelegate {

    var paymentVaultViewModel : PaymentVaultViewModel!
    //var callbackCancel : ((Void) -> Void)?
    
    init(flowConfigure : FlowConfigure, paymentVaultViewModel : PaymentVaultViewModel){
        super.init(flowConfigure: flowConfigure)
        self.paymentVaultViewModel = paymentVaultViewModel
        self.state = InPaymentMethodSelection(paymentVaultViewModel: paymentVaultViewModel)
    }
    
    required init(flowConfigure: FlowConfigure) {
        fatalError("Missing paymentVaultParameter")
    }
 
    func optionSelected(_ paymentSearchItemSelected : PaymentMethodSearchItem){
        switch paymentSearchItemSelected.type.rawValue {
        case PaymentMethodSearchItemType.GROUP.rawValue:
            self.state = InPaymentMethodSelection(paymentVaultViewModel: paymentVaultViewModel, paymentMethodSearchItem: paymentSearchItemSelected)
            let paymentVaultVC = self.state!.nextStep(flowController: self)
            self.flowConfigure.navigationController!.pushViewController(paymentVaultVC, animated: true)
            break
        case PaymentMethodSearchItemType.PAYMENT_TYPE.rawValue:
            let paymentTypeId = PaymentTypeId(rawValue: paymentSearchItemSelected.idPaymentMethodSearchItem)
            
            if paymentTypeId!.isCard() {
                // PARA QUE ERA ESTO ? :|
            //    self.paymentVaultViewModel.paymentPreference!.defaultPaymentTypeId = paymentTypeId.map { $0.rawValue }
                MPFlowBuilder.startCardFlow(self.paymentVaultViewModel.paymentPreference, amount: self.paymentVaultViewModel.amount, paymentMethods : self.paymentVaultViewModel.paymentMethods,
                                                           navigationController : self.flowConfigure.navigationController!,
                                                           callback: { (paymentMethod, token, issuer, payerCost) in
                    self.paymentVaultViewModel.callback!(paymentMethod, token, issuer, payerCost)
                }, callbackCancel: {
                    //cancelPaymentCallback()
                })

            } else {
                if (paymentSearchItemSelected.children.count > 0) {
                    self.state = InPaymentMethodSelection(paymentVaultViewModel: paymentVaultViewModel, paymentMethodSearchItem: paymentSearchItemSelected)
                    let paymentVaultVC = self.state!.nextStep(flowController: self)
                    self.flowConfigure.navigationController!.pushViewController(paymentVaultVC, animated: true)
                    //paymentVault.viewModel!.isRoot = false
                    //self.navigationController!.pushViewController(paymentVault, animated: true)
                }
                
            }
            break
        case PaymentMethodSearchItemType.PAYMENT_METHOD.rawValue:
            if paymentSearchItemSelected.idPaymentMethodSearchItem == PaymentTypeId.BITCOIN.rawValue {
                
            } else {
                // Offline Payment Method
                let offlinePaymentMethodSelected = Utils.findPaymentMethod(self.paymentVaultViewModel.paymentMethods, paymentMethodId: paymentSearchItemSelected.idPaymentMethodSearchItem)
                self.paymentVaultViewModel.callback!(offlinePaymentMethodSelected, nil, nil, nil)
                self.popToFlowRootController()
            }
            break
        default:
            //TODO : HANDLE ERROR
            break
        }

    }
}


class InPaymentMethodSelection : State {
    var paymentVaultViewModel : PaymentVaultViewModel!
    var paymentMethodSearchItem : PaymentMethodSearchItem?
    
    init(paymentVaultViewModel : PaymentVaultViewModel, paymentMethodSearchItem : PaymentMethodSearchItem) {
        super.init()
        self.paymentVaultViewModel = paymentVaultViewModel
        self.paymentMethodSearchItem = paymentMethodSearchItem
    }
    
    init(paymentVaultViewModel : PaymentVaultViewModel){
        super.init()
        self.paymentVaultViewModel = paymentVaultViewModel
    }
    
    override func nextStep(flowController: FlowController) -> UIViewController {
        let paymentVault : PaymentVaultViewController!
        if self.paymentMethodSearchItem != nil {
            paymentVault = PaymentVaultViewController(amount: self.paymentVaultViewModel.amount, paymentPreference: self.paymentVaultViewModel.paymentPreference, paymentMethodSearchItem: paymentMethodSearchItem!.children, paymentMethods : self.paymentVaultViewModel.paymentMethods, title:paymentMethodSearchItem!.childrenHeader, callback: { (paymentMethod: PaymentMethod, token: Token?, issuer: Issuer?, payerCost: PayerCost?) -> Void in
                self.paymentVaultViewModel.callback!(paymentMethod, token, issuer, payerCost)
            })

        } else {
            paymentVault = PaymentVaultViewController(paymentVaultViewModel: self.paymentVaultViewModel)
        }
        
        paymentVault.delegate = flowController as! PaymentMethodSelectedDelegate
        return paymentVault
    }
}


protocol PaymentMethodSelectedDelegate {
    func optionSelected(_ paymentSearchItemSelected : PaymentMethodSearchItem)
}
