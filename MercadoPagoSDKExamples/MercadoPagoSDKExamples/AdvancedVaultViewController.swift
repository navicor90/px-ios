//
//  AdvancedVaultViewController.swift
//  MercadoPagoSDK
//
//  Created by Matias Gualino on 3/2/15.
//  Copyright (c) 2015 com.mercadopago. All rights reserved.
//

import Foundation
import MercadoPagoSDK

class AdvancedVaultViewController : SimpleVaultViewController {
//    
//    @IBOutlet weak var installmentsCell : MPInstallmentsTableViewCell!
//    var payerCosts : [PayerCost]?
//    var selectedPayerCost : PayerCost? = nil
//    var amount : Double = 0
//    
//    var selectedIssuer : Issuer? = nil
//    var advancedCallback : ((_ paymentMethod: PaymentMethod, _ token: String?, _ issuer: Issuer?, _ installments: Int) -> Void)?
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    init(merchantPublicKey: String, merchantBaseUrl: String, merchantGetCustomerUri: String, merchantAccessToken: String, amount: Double, paymentPreference: PaymentPreference?, callback: ((_ paymentMethod: PaymentMethod, _ token: String?, _ issuer: Issuer?, _ installments: Int) -> Void)?) {
//        super.init(merchantPublicKey: merchantPublicKey, merchantBaseUrl: merchantBaseUrl, merchantGetCustomerUri: merchantGetCustomerUri, merchantAccessToken: merchantAccessToken, paymentPreference: paymentPreference, callback: nil)
//        advancedCallback = callback
//        self.amount = amount
//    }
// 
//    override func getSelectionCallbackPaymentMethod() -> (_ paymentMethod : PaymentMethod) -> Void {
//        return { (paymentMethod : PaymentMethod) -> Void in
//            self.selectedCard = nil
//            self.selectedPaymentMethod = paymentMethod
//            if paymentMethod.settings != nil && paymentMethod.settings.count > 0 {
//                self.securityCodeLength = paymentMethod.settings![0].securityCode!.length
//                self.securityCodeRequired = self.securityCodeLength != 0
//            }
//            let newCardViewController = MPStepBuilder.startNewCardStep(self.selectedPaymentMethod!, requireSecurityCode: self.securityCodeRequired, callback: self.getNewCardCallback())
//            
//            if self.selectedPaymentMethod!.isIssuerRequired() {
//                let issuerViewController = MPStepBuilder.startIssuerForm(self.selectedPaymentMethod!,
//                    callback: { (issuer: Issuer) -> Void in
//                        self.selectedIssuer = issuer
//						self.showViewController(newCardViewController)
//                })
//                self.showViewController(issuerViewController)
//            } else {
//                self.showViewController(newCardViewController)
//            }
//        }
//    }
// 
//    override func getNewCardCallback() -> (_ cardToken: CardToken) -> Void {
//        return { (cardToken: CardToken) -> Void in
//            self.selectedCardToken = cardToken
//            self.bin = self.selectedCardToken?.getBin()
//            if self.selectedPaymentMethod!.settings != nil && self.selectedPaymentMethod!.settings.count > 0 {
//                self.securityCodeLength = self.selectedPaymentMethod!.settings![0].securityCode!.length
//				self.securityCodeRequired = self.securityCodeLength != 0
//            }
//            self.loadPayerCosts()
//            self.navigationController!.popToViewController(self, animated: true)
//        }
//    }
//    
//    override func getCustomerPaymentMethodCallback(_ paymentMethodsViewController : PaymentMethodsViewController) -> (_ selectedCard: Card?) -> Void {
//        return {(selectedCard: Card?) -> Void in
//            if selectedCard != nil {
//                self.selectedCard = selectedCard
//                self.selectedPaymentMethod = self.selectedCard?.paymentMethod
//                self.selectedIssuer = self.selectedCard?.issuer
//                self.bin = self.selectedCard?.firstSixDigits
//                self.securityCodeLength = self.selectedCard!.securityCode!.length
//                self.securityCodeRequired = self.securityCodeLength > 0
//                self.loadPayerCosts()
//                self.navigationController!.popViewController(animated: true)
//            } else {
//                self.showViewController(paymentMethodsViewController)
//            }
//        }
//    }
//    
//    override func declareAndInitCells() {
//        super.declareAndInitCells()
//        let installmentsNib = UINib(nibName: "MPInstallmentsTableViewCell", bundle: MercadoPago.getBundle())
//        self.tableview.register(installmentsNib, forCellReuseIdentifier: "installmentsCell")
//        self.installmentsCell = self.tableview.dequeueReusableCell(withIdentifier: "installmentsCell") as! MPInstallmentsTableViewCell
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.selectedCard == nil && self.selectedCardToken == nil {
//            return 1
//        }
//        else if self.selectedPayerCost == nil {
//            return 2
//        } else if !securityCodeRequired {
//            return 2
//        }
//        return 3
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (indexPath as NSIndexPath).row == 0 {
//            if (self.selectedCardToken == nil && self.selectedCard == nil) {
//                self.emptyPaymentMethodCell = self.tableview.dequeueReusableCell(withIdentifier: "emptyPaymentMethodCell") as! MPPaymentMethodEmptyTableViewCell
//                return self.emptyPaymentMethodCell
//            } else {
//                self.paymentMethodCell = self.tableview.dequeueReusableCell(withIdentifier: "paymentMethodCell") as! MPPaymentMethodTableViewCell
//                if self.selectedCardToken != nil {
//                    self.paymentMethodCell.fillWithCardTokenAndPaymentMethod(self.selectedCardToken, paymentMethod: self.selectedPaymentMethod!)
//                } else {
//                    self.paymentMethodCell.fillWithCard(self.selectedCard)
//                }
//                return self.paymentMethodCell
//            }
//        } else if (indexPath as NSIndexPath).row == 1 {
//            self.installmentsCell = self.tableview.dequeueReusableCell(withIdentifier: "installmentsCell") as! MPInstallmentsTableViewCell
//            self.installmentsCell.fillWithPayerCost(self.selectedPayerCost, amount: self.amount)
//            return self.installmentsCell
//        } else if (indexPath as NSIndexPath).row == 2 {
//            self.securityCodeCell = self.tableview.dequeueReusableCell(withIdentifier: "securityCodeCell") as! MPSecurityCodeTableViewCell
//            self.securityCodeCell.fillWithPaymentMethod(self.selectedPaymentMethod!)
//            self.securityCodeCell.securityCodeTextField.delegate = self
//            return self.securityCodeCell
//        }
//        return UITableViewCell()
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if ((indexPath as NSIndexPath).row == 2) {
//            return 143
//        }
//        return 65
//    }
//    
//    func loadPayerCosts() {
//        self.view.addSubview(self.loadingView)
//        
//        let issuer = self.selectedIssuer != nil ? self.selectedIssuer : nil
//        
//        MPServicesBuilder.getInstallments(self.bin!, amount: self.amount, issuer: issuer, paymentMethodId: self.selectedPaymentMethod!._id, success: { (installments) in
//            if installments != nil {
//                self.payerCosts = installments![0].payerCosts
//                self.tableview.reloadData()
//                self.loadingView.removeFromSuperview()
//            }
//            }) { (error) in
//                MercadoPago.showAlertViewWithError(error, nav: self.navigationController)
//                self.navigationController?.popToRootViewController(animated: true)
//        }
//
//    }
//	
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        if (indexPath as NSIndexPath).row == 0 {
////            super.tableView(tableView, didSelectRowAt: indexPath)
////        } else if (indexPath as NSIndexPath).row == 1 {
////
////            self.showViewController(MPStepBuilder.startInstallmentsStep(payerCosts!, amount: amount, issuer:nil, paymentMethodId: nil,callback: { (payerCost: PayerCost?) -> Void in
////                self.selectedPayerCost = payerCost
////                self.tableview.reloadData()
////                self.navigationController!.popToViewController(self, animated: true)
////            }))
////        }
//    }
//	
//    override func submitForm() {
//        
//        let mercadoPago : MercadoPago = MercadoPago(publicKey: self.publicKey!)
//        
//        // Create token
//        if selectedCard != nil {
//            
//            let savedCardToken : SavedCardToken = SavedCardToken(card: selectedCard!, securityCode: securityCodeCell.securityCodeTextField.text!, securityCodeRequired : self.securityCodeRequired)
//            
//            if savedCardToken.validate() {
//                // Send card id to get token id
//                self.view.addSubview(self.loadingView)
//				
//				let installments = self.selectedPayerCost == nil ? 0 : self.selectedPayerCost!.installments
//				
//                mercadoPago.createToken(savedCardToken, success: {(token: Token?) -> Void in
//					self.loadingView.removeFromSuperview()
//                    self.advancedCallback!(self.selectedPaymentMethod!, token?._id, self.selectedIssuer, installments)
//                }, failure: nil)
//            } else {
//
//                return
//            }
//        } else {
//            self.selectedCardToken!.securityCode = self.securityCodeCell.securityCodeTextField.text
//            self.view.addSubview(self.loadingView)
//			
//			let installments = self.selectedPayerCost == nil ? 0 : self.selectedPayerCost!.installments
//			
//            mercadoPago.createNewCardToken(self.selectedCardToken!, success: {(token: Token?) -> Void in
//					self.loadingView.removeFromSuperview()
//                    self.advancedCallback!(self.selectedPaymentMethod!, token?._id, self.selectedIssuer, installments)
//            }, failure: nil)
//        }
//    }

}
