//
//  CardFormFlowController.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 1/17/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

class CardFormFlowController: FlowController {

    
    
    var cardViewModelManager : CardViewModelManager?
    var callback : ((_ paymentMethod: PaymentMethod, _ token: Token, _ issuer:Issuer?) -> Void)!
    var callbackCancel : ((Void) -> Void)?
    
    required init(flowConfigure : FlowConfigure, cardViewModelManager : CardViewModelManager, callback : @escaping (_ paymentMethod: PaymentMethod, _ token: Token, _ issuer:Issuer?) -> Void, callbackCancel : ((Void) -> Void)?) {
        super.init(flowConfigure: flowConfigure)
        self.callback = callback
        self.callbackCancel = callbackCancel
        self.state = InCardForm(cardViewModelManager: cardViewModelManager)
    }
    
    required init(flowConfigure: FlowConfigure) {
        fatalError("init(flowConfigure:) has not been implemented")
    }
    
//    func start(){
//        let navigationController = self.flowConfigure.navigationController
//
//        let vc = self.state!.nextStep(flowController: self)
//        navigationController!.pushViewController(vc, animated: true)
//    }
    
}

class State : NSObject {
    
    var cardViewModelManager : CardViewModelManager?

    override init(){
    
    }
    
    init(cardViewModelManager : CardViewModelManager) {
        self.cardViewModelManager = cardViewModelManager
    }
    
    func nextStep(flowController : FlowController) -> UIViewController {
        // tendria que ser abstracto, existe tal cosa en swift?
        return UIViewController()
    }
}

class InCardForm : State {
    
    override func nextStep(flowController : FlowController) -> UIViewController {
        return CardFormViewController(cardViewModelManager: self.cardViewModelManager!, callback: { (paymentMethod: [PaymentMethod], cardToken: CardToken?) -> Void in
            self.cardViewModelManager!.paymentMethods = paymentMethod
            self.cardViewModelManager!.cardToken = cardToken
            if self.cardViewModelManager!.isIdentificationRequired() {
                flowController.state = InIdentification(cardViewModelManager: self.cardViewModelManager!)
            } else  {
                flowController.state = InCreditDebitSelection(cardViewModelManager: self.cardViewModelManager!)
            }
            let vc = flowController.state!.nextStep(flowController: flowController)
            flowController.flowConfigure.navigationController!.pushViewController(vc, animated: true)
        })
    }
}

class InIdentification : State {
    
    override func nextStep(flowController : FlowController) -> UIViewController {
        return  IdentificationViewController { (identification :Identification) in
            self.cardViewModelManager!.updateIdentification(identification: identification)
            if self.cardViewModelManager!.isCreditAndDebitAvailable() {
                flowController.state = InCreditDebitSelection(cardViewModelManager: self.cardViewModelManager!)
            } else {
                flowController.state = InIssuersSelection(cardViewModelManager: self.cardViewModelManager!)
            }
            let vc = flowController.state!.nextStep(flowController: flowController)
            flowController.flowConfigure.navigationController!.pushViewController(vc, animated: true)
            
        }
    }
}

class InCreditDebitSelection : State {
    
    override func nextStep(flowController : FlowController) -> UIViewController {
        return CardAdditionalStep(paymentMethod: cardViewModelManager!.paymentMethods!, issuer: nil, token: cardViewModelManager!.token, amount: cardViewModelManager!.amount, paymentPreference: cardViewModelManager!.paymentSettings, installment : nil, callback: { (selectedPaymentMethod) in
            self.cardViewModelManager?.selectedPaymentMethod = selectedPaymentMethod as? PaymentMethod
            flowController.state = InIssuersSelection(cardViewModelManager: self.cardViewModelManager!)
            let vc = flowController.state!.nextStep(flowController: flowController)
            flowController.flowConfigure.navigationController!.pushViewController(vc, animated: true)
        })
        
    
    }
}

class InIssuersSelection : State {

    override func nextStep(flowController : FlowController) -> UIViewController {
        return CardAdditionalStep(paymentMethod: [self.cardViewModelManager!.getSelectedPaymentMethod()!], issuer: nil, token: self.cardViewModelManager!.cardToken, amount: nil, paymentPreference: nil, installment : nil, callback: { (issuer) -> Void in
            self.cardViewModelManager!.issuer = issuer as! Issuer?
            MPServicesBuilder.createNewCardToken(self.cardViewModelManager!.cardToken!, success: {
                (token) -> Void in
               //(flowController as! CardFormFlowController).flowConfigure.navigationController?.popToViewController(flowController.rootViewController!, animated: true)
                
                flowController.popToFlowRootController()
                (flowController as! CardFormFlowController).callback(self.cardViewModelManager!.getSelectedPaymentMethod()!, token!, issuer as? Issuer)
            }) { (error) -> Void in
                flowController.state = InError()
            }
  
        })
    }
}

class InInstallmentsSelection : State {
    
    override func nextStep(flowController : FlowController) -> UIViewController {
        return CardAdditionalStep(paymentMethod: [self.cardViewModelManager!.getSelectedPaymentMethod()!], issuer: self.cardViewModelManager!.issuer, token: self.cardViewModelManager!.cardToken, amount: self.cardViewModelManager!.amount, paymentPreference: cardViewModelManager!.paymentSettings, installment: nil, callback: { (payerCost : NSObject?) -> Void in
            self.cardViewModelManager!.installment = payerCost as! PayerCost
            flowController.popToFlowRootController()
            //callback
        })
    }
}

class InError : State {

    override func nextStep(flowController : FlowController) -> UIViewController {
     //   let errorVC = MPStepBuilder.startErrorViewController(MPSDKError.convertFrom(error), callback: { (Void) in
            //self.getIssuers(paymentMethod, cardToken: cardToken, ccf: ccf, callback: callback)
      //  }, callbackCancel: {
            //ccf.navigationController?.dismiss(animated: true, completion: {})
       // })
        //ccf.navigationController?.present(errorVC, animated: true, completion: {})
        //return errorVc
        return UIViewController()
    
    }

}


