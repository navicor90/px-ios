//
//  CheckoutViewController.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 13/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class CheckoutViewController: MercadoPagoUIViewController, UITableViewDataSource, UITableViewDelegate {

    var preference: CheckoutPreference?
    var publicKey: String!
    var accessToken: String!
    var bundle: NSBundle? = MercadoPago.getBundle()
    var callback: (Payment -> Void)!
    var paymentMethod: PaymentMethod?
    var installments: Int = 0
    var issuer: Issuer?
    var tokenId: String?

    private var reviewAndConfirmContent = Set<String>()

    @IBOutlet weak var checkoutTable: UITableView!

    @IBOutlet weak var confirmPaymentButton: UIButton!

    init(preference: CheckoutPreference, callback: (Payment -> Void)) {
        super.init(nibName: "CheckoutViewController", bundle: MercadoPago.getBundle())
        self.preference = preference
        self.publicKey = MercadoPagoContext.publicKey()
        self.accessToken = MercadoPagoContext.merchantAccessToken()
        self.callback = callback
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        //Display preference description by default
        self.displayPreferenceDescription = true

        self.title = "¿Cómo quieres pagar?".localized

        //Register rows
        let offlinePaymentMethodNib = UINib(nibName: "OfflinePaymentMethodCell", bundle: self.bundle)
        self.checkoutTable.registerNib(offlinePaymentMethodNib, forCellReuseIdentifier: "offlinePaymentCell")
        let preferenceDescriptionCell = UINib(nibName: "PreferenceDescriptionTableViewCell", bundle: self.bundle)
        self.checkoutTable.registerNib(preferenceDescriptionCell, forCellReuseIdentifier: "preferenceDescriptionCell")
        let selectPaymentMethodCell = UINib(nibName: "SelectPaymentMethodCell", bundle: self.bundle)
        self.checkoutTable.registerNib(selectPaymentMethodCell, forCellReuseIdentifier: "selectPaymentMethodCell")

        self.checkoutTable.contentInset = UIEdgeInsets(top: -35.0, left: 0.0, bottom: 0.0, right: 0.0)

        self.checkoutTable.delegate = self
        self.checkoutTable.dataSource = self

        self.confirmPaymentButton.addTarget(self, action: "confirmPayment", forControlEvents: .TouchUpInside)
        self.confirmPaymentButton.layer.cornerRadius = 5
        self.confirmPaymentButton.clipsToBounds = true
        self.confirmPaymentButton.setAttributedTitle(NSAttributedString(string: "Pagar $".localized +  String(preference!.getAmount())), forState: .Normal)
        if self.paymentMethod == nil {
            self.confirmPaymentButton.hidden = true
        }

        //Shopping cart button
        self.navigationItem.rightBarButtonItem?.action = Selector("togglePreferenceDescription")
        self.navigationItem.rightBarButtonItem?.target = self

        //Clear styles before leaving SDK
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Atrás".localized, style: UIBarButtonItemStyle.Bordered, target: self, action: "clearMercadoPagoStyleAndGoBackAnimated")
        self.navigationItem.leftBarButtonItem?.target = self

        self.startPaymentVault()
    }

    override public func viewWillAppear(animated: Bool) {
        self.loadMPStyles()
        if self.paymentMethod != nil {
            self.confirmPaymentButton.hidden = false
        }

    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 20
    }

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if self.displayPreferenceDescription {
                return 120
            }
            return 0
        }
        return 100
    }

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.displayPreferenceDescription ? 1 : 0
        }
        return 1
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let preferenceDescriptionCell = tableView.dequeueReusableCellWithIdentifier("preferenceDescriptionCell", forIndexPath: indexPath) as! PreferenceDescriptionTableViewCell
            preferenceDescriptionCell.fillRowWithPreference(self.preference!)
            preferenceDescriptionCell.selectionStyle = UITableViewCellSelectionStyle.None
            return preferenceDescriptionCell
        }

        if self.paymentMethod != nil {
            //TODO : solo funciona con offlinePayment
                let cell = tableView.dequeueReusableCellWithIdentifier("offlinePaymentCell", forIndexPath: indexPath) as! OfflinePaymentMethodCell
                cell.fillRowWithPaymentMethod(self.paymentMethod!)
                return cell
        }

        return tableView.dequeueReusableCellWithIdentifier("selectPaymentMethodCell", forIndexPath: indexPath) as! SelectPaymentMethodCell
    }

    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            self.checkoutTable.deselectRowAtIndexPath(indexPath, animated: true)
        } else {
            self.checkoutTable.deselectRowAtIndexPath(indexPath, animated: true)
            self.startPaymentVault()
        }

    }

    internal func startPaymentVault() {
        let paymentVault = MPFlowBuilder.startPaymentVaultViewController((preference?.getAmount())!, currencyId: (preference?.items![0].currencyId), purchaseTitle: (preference?.items![0].title)!, excludedPaymentTypes: preference!.getExcludedPaymentTypes(), excludedPaymentMethods: preference!.getExcludedPaymentMethods(), callback: { (paymentMethod, tokenId, issuer, installments) -> Void in
            self.navigationController?.popToViewController(self, animated: true)
            self.paymentMethod = paymentMethod
            self.tokenId = tokenId
            self.issuer = issuer
            self.installments = installments

            self.reviewAndConfirmContent.insert("paymentInfo")

            self.checkoutTable.reloadData()
        })
        self.navigationController?.pushViewController(paymentVault, animated: true)
    }

    internal func confirmPayment() {
        let payment = Payment()
        payment.transactionAmount = self.preference!.getAmount()
        payment.tokenId = self.tokenId
        payment.issuerId = self.issuer != nil ? self.issuer!._id!.integerValue : 0
        payment.paymentMethodId = self.paymentMethod!._id
        payment._description = "description"

        MercadoPago.createMPPayment(payment, success: { (payment) -> Void in
            if self.paymentMethod!.isOfflinePaymentMethod() {
                //TODO : enviar paymentId!!!
                payment._id = 1826446924
                payment.paymentMethodId = "bancomer_bank_transfer"
                self.navigationController?.pushViewController(MPStepBuilder.startInstructionsStep(payment, callback: {(payment : Payment) -> Void  in
                    self.clearMercadoPagoStyleAndGoBack()
                    self.callback(payment)
                }), animated: true)
            } else {
                self.navigationController?.popViewControllerAnimated(true)
            }

            }) { (_) -> Void in
                //TODO

        }
    }

    internal func togglePreferenceDescription() {
        self.togglePreferenceDescription(self.checkoutTable)
    }

}
