//
//  PaymentVaultViewController.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 15/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class PaymentVaultViewController: MercadoPagoUIViewController, UITableViewDataSource, UITableViewDelegate {

    var merchantBaseUrl: String!
    var merchantAccessToken: String!
    var publicKey: String!
    var amount: Double!
    var excludedPaymentTypes: Set<PaymentTypeId>!
    var excludedPaymentMethods: [String]!
    var currencyId: String?
    var purchaseTitle: String!
    var callback : ((paymentMethod: PaymentMethod, tokenId: String?, issuer: Issuer?, installments: Int) -> Void)!
    var paymentMethodsSearch: [PaymentMethodSearchItem]!
    var paymentMethodSearchParent: PaymentMethodSearchItem?
    var defaultInstallments: Int?
    var installments: Int?

    var bundle = MercadoPago.getBundle()

    var paymentSearchCell: PaymentSearchCell!

    private var tintColor = true

    @IBOutlet weak var paymentsTable: UITableView!

    internal init(amount: Double, paymentMethodSearch: [PaymentMethodSearchItem], paymentMethodSearchParent: PaymentMethodSearchItem, title: String!, callback: (paymentMethod: PaymentMethod, tokenId: String?, issuer: Issuer?, installments: Int) -> Void) {
        super.init(nibName: "PaymentVaultViewController", bundle: bundle)
        self.merchantBaseUrl = MercadoPagoContext.baseURL()
        self.merchantAccessToken = MercadoPagoContext.merchantAccessToken()
        self.publicKey = MercadoPagoContext.publicKey()
        self.title = title
        self.tintColor = false
        self.amount = amount
        self.paymentMethodSearchParent = paymentMethodSearchParent
        self.paymentMethodsSearch = paymentMethodSearch
        self.callback = {(paymentMethod: PaymentMethod, tokenId: String?, issuer: Issuer?, installments: Int) -> Void in
     //       self.navigationController?.popViewControllerAnimated(true)
            callback(paymentMethod: paymentMethod, tokenId: tokenId, issuer: issuer, installments: installments)
        }
    }

    init(amount: Double, currencyId: String?, purchaseTitle: String, excludedPaymentTypes: Set<PaymentTypeId>?, excludedPaymentMethods: [String]?, installments: Int, defaultInstallments: Int, callback: (paymentMethod: PaymentMethod, tokenId: String?, issuer: Issuer?, installments: Int) -> Void) {
        super.init(nibName: "PaymentVaultViewController", bundle: bundle)
        self.merchantBaseUrl = MercadoPagoContext.baseURL()
        self.merchantAccessToken = MercadoPagoContext.merchantAccessToken()
        self.publicKey = MercadoPagoContext.publicKey()
        self.amount = amount
        self.excludedPaymentTypes = excludedPaymentTypes
        self.excludedPaymentMethods = excludedPaymentMethods
        self.purchaseTitle = purchaseTitle
        self.currencyId = currencyId
        self.callback = {(paymentMethod: PaymentMethod, tokenId: String?, issuer: Issuer?, installments: Int) -> Void in
      //      self.navigationController?.popViewControllerAnimated(true)
            callback(paymentMethod: paymentMethod, tokenId: tokenId, issuer: issuer, installments: installments)
        }
        self.installments = installments
        self.defaultInstallments = defaultInstallments
    }

    required  public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        if self.title == nil || self.title!.isEmpty {
            self.title = "¿Cómo quieres pagar?".localized
        }

        let paymentMethodSearchNib = UINib(nibName: "PaymentSearchCell", bundle: self.bundle)
        let paymentSearchTitleCell = UINib(nibName: "PaymentTitleViewCell", bundle: self.bundle)
        let offlinePaymentMethodCell = UINib(nibName: "OfflinePaymentMethodCell", bundle: self.bundle)
        let preferenceDescriptionCell = UINib(nibName: "PreferenceDescriptionTableViewCell", bundle: self.bundle)
        let paymentTitleAndCommentCell = UINib(nibName: "PaymentTitleAndCommentViewCell", bundle: self.bundle)
        let offlinePaymentWithImageCell = UINib(nibName: "PaymentMethodImageViewCell", bundle: self.bundle)

        self.paymentsTable.registerNib(paymentTitleAndCommentCell, forCellReuseIdentifier: "paymentTitleAndCommentCell")
        self.paymentsTable.registerNib(paymentMethodSearchNib, forCellReuseIdentifier: "paymentSearchCell")
        self.paymentsTable.registerNib(paymentSearchTitleCell, forCellReuseIdentifier: "paymentSearchTitleCell")
        self.paymentsTable.registerNib(offlinePaymentMethodCell, forCellReuseIdentifier: "offlinePaymentMethodCell")
        self.paymentsTable.registerNib(preferenceDescriptionCell, forCellReuseIdentifier: "preferenceDescriptionCell")
        self.paymentsTable.registerNib(offlinePaymentWithImageCell, forCellReuseIdentifier: "offlinePaymentWithImageCell")

        //Configure navigation item button
        self.navigationItem.rightBarButtonItem!.target = self
        self.navigationItem.rightBarButtonItem!.action = Selector("togglePreferenceDescription")

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Atrás".localized, style: UIBarButtonItemStyle.Bordered, target: self, action: "executeBack")
        self.navigationItem.leftBarButtonItem?.target = self

        self.paymentsTable.contentInset = UIEdgeInsets(top: -35.0, left: 0.0, bottom: 0.0, right: 0.0)

        loadPaymentMethodGroups()

    }

    override public func viewWillAppear(animated: Bool) {
        self.loadMPStyles()
    }

    override public func viewWillDisappear(animated: Bool) {
        self.clearMercadoPagoStyle()
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.displayPreferenceDescription ? 1 : 0
        }
        return self.paymentMethodsSearch.count
    }

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 20
    }

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return displayPreferenceDescription ? 120 : 0
        }

        let currentPaymentMethod = self.paymentMethodsSearch[indexPath.row]
        if currentPaymentMethod.isPaymentMethod() && !currentPaymentMethod.isBitcoin() {
            return 80
        }
        return 52
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Preference description section
        if indexPath.section == 0 {
            let preferenceDescriptionCell = self.paymentsTable.dequeueReusableCellWithIdentifier("preferenceDescriptionCell") as! PreferenceDescriptionTableViewCell
            preferenceDescriptionCell.preferenceDescription.text = self.purchaseTitle
            return preferenceDescriptionCell
        }

        let currentPaymentMethod = self.paymentMethodsSearch[indexPath.row]
        let iconImage = MercadoPago.getImage(currentPaymentMethod.idPaymentMethodSearchItem)
        let tintColor = self.tintColor && (!currentPaymentMethod.isPaymentMethod() || currentPaymentMethod.isBitcoin())

        if iconImage != nil {
            if currentPaymentMethod.isPaymentMethod() && !currentPaymentMethod.isBitcoin() {
                if currentPaymentMethod.comment != nil && currentPaymentMethod.comment!.characters.count > 0 {
                    let offlinePaymentCell = self.paymentsTable.dequeueReusableCellWithIdentifier("offlinePaymentMethodCell") as! OfflinePaymentMethodCell
                    offlinePaymentCell.iconImage.image = iconImage!
                    offlinePaymentCell.comment.text = currentPaymentMethod.comment!
                    return offlinePaymentCell
                } else {
                    let offlinePaymentCellWithImage = self.paymentsTable.dequeueReusableCellWithIdentifier("offlinePaymentWithImageCell") as! PaymentMethodImageViewCell
                    offlinePaymentCellWithImage.paymentMethodImage.image = iconImage
                    return offlinePaymentCellWithImage
                }
            } else {
                let paymentSearchCell = self.paymentsTable.dequeueReusableCellWithIdentifier("paymentSearchCell") as! PaymentSearchCell
                paymentSearchCell.fillRowWithPayment(self.paymentMethodsSearch[indexPath.row], iconImage : iconImage!, tintColor: tintColor)

                return paymentSearchCell
            }
        }

        if currentPaymentMethod.comment != nil && currentPaymentMethod.comment?.characters.count > 0 {
            let paymentSearchTitleAndCommentCell = self.paymentsTable.dequeueReusableCellWithIdentifier("paymentTitleAndCommentCell") as! PaymentTitleAndCommentViewCell
            paymentSearchTitleAndCommentCell.fillRowWith(currentPaymentMethod.description, paymentComment: currentPaymentMethod.comment!)
            return paymentSearchTitleAndCommentCell
        }

        let paymentSearchCell = self.paymentsTable.dequeueReusableCellWithIdentifier("paymentSearchTitleCell") as! PaymentTitleViewCell
        paymentSearchCell.paymentTitle.text = currentPaymentMethod.description
        return paymentSearchCell

    }

    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let paymentSearchItemSelected = self.paymentMethodsSearch[indexPath.row]
        self.paymentsTable.deselectRowAtIndexPath(indexPath, animated: true)

        if (paymentSearchItemSelected.children.count > 0) {
            self.navigationController?.pushViewController(PaymentVaultViewController(amount: self.amount, paymentMethodSearch: paymentSearchItemSelected.children, paymentMethodSearchParent: paymentSearchItemSelected, title:paymentSearchItemSelected.childrenHeader, callback: { (paymentMethod: PaymentMethod, tokenId: String?, issuer: Issuer?, installments: Int) -> Void in

                self.callback(paymentMethod: paymentMethod, tokenId: nil, issuer: nil, installments: 1)
            }), animated: true)
        } else  if paymentSearchItemSelected.type == PaymentMethodSearchItemType.PAYMENT_TYPE {

            let paymentTypeId = PaymentTypeId(rawValue: paymentSearchItemSelected.idPaymentMethodSearchItem)

            if paymentTypeId!.isCard() {
                self.cardFlow(PaymentType(paymentTypeId: paymentTypeId!))
            } else {
                self.navigationController?.pushViewController(MPStepBuilder.startPaymentMethodsStep([PaymentTypeId(rawValue: paymentSearchItemSelected.idPaymentMethodSearchItem)!], callback: { (paymentMethod : PaymentMethod) -> Void in
                    //TODO : verificar que con off issuer/installments es asi
                    self.callback(paymentMethod: paymentMethod, tokenId: nil, issuer: nil, installments: 1)
                }), animated: true)
            }
        } else if paymentSearchItemSelected.type == PaymentMethodSearchItemType.PAYMENT_METHOD {
            if paymentSearchItemSelected.idPaymentMethodSearchItem == "account_money" {
                //wallet
            } else if paymentSearchItemSelected.idPaymentMethodSearchItem == "digital_currency" {

            } else {
                //if atm-ticket -bitcoin
                //TODO: ir a buscarlo!!!
                let paymentMethod = PaymentMethod()
                paymentMethod._id = paymentSearchItemSelected.idPaymentMethodSearchItem
                paymentMethod.comment = paymentSearchItemSelected.comment
                //TODO: esto explota si pm esta en origen
                paymentMethod.paymentTypeId = PaymentTypeId(rawValue: self.paymentMethodSearchParent!.idPaymentMethodSearchItem)
                self.callback(paymentMethod: paymentMethod, tokenId: nil, issuer: nil, installments: 1)
                //else if cc
            }
        }
    }

    private func loadPaymentMethodGroups() {
        if paymentMethodsSearch == nil {
            MPServicesBuilder.searchPaymentMethods(self.excludedPaymentTypes, excludedPaymentMethods: self.excludedPaymentMethods, success: { (paymentMethodSearchResponse: PaymentMethodSearch) -> Void in

                self.paymentMethodsSearch = paymentMethodSearchResponse.groups
                self.paymentsTable.delegate = self
                self.paymentsTable.dataSource = self

                self.paymentsTable.reloadData()
                }, failure: { (_) -> Void in
                    //TODO
            })
        } else {
            self.paymentsTable.delegate = self
            self.paymentsTable.dataSource = self

            self.paymentsTable.reloadData()
        }

    }

    internal func cardFlow(paymentType: PaymentType) {
        self.navigationController?.pushViewController(MPStepBuilder.startCreditCardForm(paymentType, callback: { (paymentMethod, token, issuer, _) -> Void in
            //TODO
            //self.navigationController?.popViewControllerAnimated(true)
            self.callback!(paymentMethod: paymentMethod, tokenId: token?._id, issuer: issuer, installments: 1)
        }), animated: true)
    }

    internal func executeBack() {
        self.clearMercadoPagoStyle()
        self.navigationController?.popViewControllerAnimated(true)
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    internal func togglePreferenceDescription() {
        self.togglePreferenceDescription(self.paymentsTable)
    }

}
