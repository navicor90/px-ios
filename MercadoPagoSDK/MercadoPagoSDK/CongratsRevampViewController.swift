//
//  CongratsRevampViewController.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 10/25/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

open class CongratsRevampViewController: MercadoPagoUIViewController, UITableViewDelegate, UITableViewDataSource, MPCustomRowDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var bundle = MercadoPago.getBundle()
    var viewModel: CongratsViewModel!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 60
        self.tableView.separatorStyle = .none
        
        addUpperScrollingFrame()
        registerCells()
    }
    
    func addUpperScrollingFrame() {
        var frame = self.tableView.bounds
        frame.origin.y = -frame.size.height;
        let view = UIView(frame: frame)
        view.backgroundColor = self.viewModel.getColor()
        tableView.addSubview(view)
    }
    
    func registerCells() {
        
        let headerNib = UINib(nibName: "HeaderCongratsTableViewCell", bundle: self.bundle)
        self.tableView.register(headerNib, forCellReuseIdentifier: "headerNib")
        let emailNib = UINib(nibName: "ConfirmEmailTableViewCell", bundle: self.bundle)
        self.tableView.register(emailNib, forCellReuseIdentifier: "emailNib")
        let approvedNib = UINib(nibName: "ApprovedTableViewCell", bundle: self.bundle)
        self.tableView.register(approvedNib, forCellReuseIdentifier: "approvedNib")
        let rejectedNib = UINib(nibName: "RejectedTableViewCell", bundle: self.bundle)
        self.tableView.register(rejectedNib, forCellReuseIdentifier: "rejectedNib")
        let callFAuthNib = UINib(nibName: "CallForAuthTableViewCell", bundle: self.bundle)
        self.tableView.register(callFAuthNib, forCellReuseIdentifier: "callFAuthNib")
        let footerNib = UINib(nibName: "FooterTableViewCell", bundle: self.bundle)
        self.tableView.register(footerNib, forCellReuseIdentifier: "footerNib")
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController != nil && self.navigationController?.navigationBar != nil {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            ViewUtils.addStatusBar(self.view, color: self.viewModel.getColor())
        }
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MPTracker.trackPaymentEvent(self.viewModel.paymentResult.paymentData?.token?._id, mpDelegate: MercadoPagoContext.sharedInstance, paymentInformer: self.viewModel, flavor: Flavor(rawValue: "3"), action: "CREATE_PAYMENT", result:nil)
    }
    
    init(paymentResult: PaymentResult, callback : @escaping (_ status : MPStepBuilder.CongratsState) -> Void){
        super.init(nibName: "CongratsRevampViewController", bundle : bundle)
        self.viewModel = CongratsViewModel(paymentResult: paymentResult, callback: callback)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.isAdditionalCustomCellFor(indexPath: indexPath){
            if viewModel.inProcess(){
                return PaymentResultScreenPreference.pendingAdditionalInfoCells[indexPath.row].getHeight()
            } else if viewModel.approved(){
                return PaymentResultScreenPreference.approvedAdditionalInfoCells[indexPath.row].getHeight()
            }
        }
        return UITableViewAutomaticDimension
        
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section: section)
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isHeaderCellFor(indexPath: indexPath) {
            return self.getHeaderCell(indexPath: indexPath)
            
        } else if viewModel.isApprovedBodyCellFor(indexPath: indexPath){
            return getApprovedBodyCell()
            
        } else if viewModel.isEmailCellFor(indexPath: indexPath) {
            return getConfirmEmailCell()
            
        } else if viewModel.isCallForAuthFor(indexPath: indexPath) {
            return getCallForAuthCell()
            
        } else if viewModel.isSelectOtherPaymentMethodCellFor(indexPath: indexPath){
            if viewModel.callForAuth() {
                return getOtherPaymentMethodCell(drawLine: true)
            }
            return getOtherPaymentMethodCell(drawLine: false)
            
        } else if viewModel.isAdditionalCustomCellFor(indexPath: indexPath){
            return getAdditionalCustomCell(indexPath: indexPath)
        
        } else if viewModel.isFooterCellFor(indexPath: indexPath){
            return getFooterCell()
        }
        
        return UITableViewCell()
    }
    
    private func getHeaderCell(indexPath: IndexPath) -> UITableViewCell {
        let headerCell = self.tableView.dequeueReusableCell(withIdentifier: "headerNib") as! HeaderCongratsTableViewCell
        headerCell.fillCell(paymentResult: self.viewModel.paymentResult!, paymentMethod: self.viewModel.paymentResult.paymentData?.paymentMethod, color: self.viewModel.getColor())
        return headerCell
    }
    
    private func getFooterCell() -> UITableViewCell {
        let footerNib = self.tableView.dequeueReusableCell(withIdentifier: "footerNib") as! FooterTableViewCell
        footerNib.setCallbackStatus(callback: self.viewModel.callback, status: MPStepBuilder.CongratsState.ok)
        footerNib.fillCell(paymentResult: self.viewModel.paymentResult)
        if self.viewModel.approved(){
            ViewUtils.drawBottomLine(y: footerNib.contentView.frame.minY, width: UIScreen.main.bounds.width, inView: footerNib.contentView)
        }
        return footerNib
    }
    
    private func getApprovedBodyCell() -> UITableViewCell {
        let approvedCell = self.tableView.dequeueReusableCell(withIdentifier: "approvedNib") as! ApprovedTableViewCell
        approvedCell.fillCell(paymentResult: self.viewModel.paymentResult!)
        return approvedCell
    }
    
    private func getConfirmEmailCell() -> UITableViewCell {
        let confirmEmailCell = self.tableView.dequeueReusableCell(withIdentifier: "emailNib") as! ConfirmEmailTableViewCell
        confirmEmailCell.fillCell(paymentResult: self.viewModel.paymentResult!, instruction:nil)
        ViewUtils.drawBottomLine(y: confirmEmailCell.contentView.frame.minY, width: UIScreen.main.bounds.width, inView: confirmEmailCell.contentView)
        return confirmEmailCell
    }
    
    private func getOtherPaymentMethodCell(drawLine: Bool) -> UITableViewCell {
        let rejectedCell = self.tableView.dequeueReusableCell(withIdentifier: "rejectedNib") as! RejectedTableViewCell
        rejectedCell.setCallbackStatusTracking(callback: self.viewModel.setCallbackWithTracker(cellName: "rejected"), paymentResult: self.viewModel.paymentResult, status: MPStepBuilder.CongratsState.cancel_RETRY)
        rejectedCell.fillCell(paymentResult: self.viewModel.paymentResult)
        if drawLine {
            ViewUtils.drawBottomLine(y: rejectedCell.contentView.frame.minY, width: UIScreen.main.bounds.width, inView: rejectedCell.contentView)
        }
        return rejectedCell
    }
    
    private func getCallForAuthCell() -> UITableViewCell {
        let callFAuthCell = self.tableView.dequeueReusableCell(withIdentifier: "callFAuthNib") as! CallForAuthTableViewCell
        callFAuthCell.setCallbackStatusTracking(callback: self.viewModel.setCallbackWithTracker(cellName: "call"), paymentResult: self.viewModel.paymentResult, status: MPStepBuilder.CongratsState.call_FOR_AUTH)
        callFAuthCell.fillCell(paymentMehtod: self.viewModel.paymentResult.paymentData?.paymentMethod)
        return callFAuthCell
    }
    
    private func getAdditionalCustomCell(indexPath: IndexPath) -> UITableViewCell {
        
        if self.viewModel.inProcess(){
            let customCell = PaymentResultScreenPreference.pendingAdditionalInfoCells[indexPath.row]
            customCell.setDelegate(delegate: self)
            return customCell.getTableViewCell()
        } else {
            let customCell = PaymentResultScreenPreference.approvedAdditionalInfoCells[indexPath.row]
            customCell.setDelegate(delegate: self)
            return customCell.getTableViewCell()
        }
    }
    
    public func invokeCallbackWithPaymentResult(rowCallback : ((PaymentResult) -> Void)) {
        rowCallback(self.viewModel.paymentResult)
    }

}

class CongratsViewModel : NSObject, MPPaymentTrackInformer {
    
    var paymentResult: PaymentResult!
    var callback: ( _ status : MPStepBuilder.CongratsState) -> Void
    
    init(paymentResult: PaymentResult, callback : @escaping ( _ status : MPStepBuilder.CongratsState) -> Void) {
        
        self.paymentResult = paymentResult
        self.callback = callback
    }
    open func methodId() -> String!{
        return paymentResult.paymentData?.paymentMethod._id ?? ""
    }
    
    open func status() -> String!{
        return paymentResult.status
    }
    
    open func statusDetail() -> String!{
        return paymentResult.statusDetail
    }
    
    open func typeId() -> String!{
        return paymentResult.paymentData?.paymentMethod.paymentTypeId ?? ""
    }
    
    open func installments() -> String! {
        return String(describing: paymentResult.paymentData?.payerCost?.installments)
    }
    
    open func issuerId() -> String!{
        return String(describing: paymentResult.paymentData?.issuer?._id)
    }
    
    func getColor() -> UIColor{
        if approved() {
            return UIColor(red: 59, green: 194, blue: 128)
        } else if inProcess() {
            return UIColor(red: 255, green: 161, blue: 90)
        } else if callForAuth() {
            return UIColor(red: 58, green: 184, blue: 239)
        } else if rejected(){
            return UIColor(red: 255, green: 89, blue: 89)
        }
        return UIColor()
    }
    
    func callForAuth() ->Bool{
        if self.paymentResult.statusDetail == "cc_rejected_call_for_authorize" {
            return true
        } else {
            return false
        }
    }
    
    func approved() -> Bool{
        if self.paymentResult.status == PaymentStatus.APPROVED.rawValue {
            return true
        } else {
            return false
        }
    }
    func inProcess() -> Bool{
        if self.paymentResult.status == PaymentStatus.IN_PROCESS.rawValue {
            return true
        } else {
            return false
        }
    }
    func rejected() -> Bool{
        if self.paymentResult.status == PaymentStatus.REJECTED.rawValue {
            return true
        } else {
            return false
        }
    }
    internal func getLayoutName() -> String! {
        
        if paymentResult.status == PaymentStatus.REJECTED.rawValue {
            if paymentResult.statusDetail == "cc_rejected_call_for_authorize" {
                return "authorize" //C4A
            } else if paymentResult.statusDetail.contains("cc_rejected_bad_filled")  {
                return "recovery" //bad fill something
            }
        }
        
        return paymentResult.status
    }
    
    func setCallbackWithTracker(cellName: String) -> (_ paymentResult : PaymentResult, _ status : MPStepBuilder.CongratsState) -> Void{
        let callbackWithTracker : (_ paymentResutl : PaymentResult, _ status : MPStepBuilder.CongratsState) -> Void = {(paymentResult ,status) in
            let paymentAction: PaymentActions
            if self.paymentResult.statusDetail.contains("cc_rejected_bad_filled"){
                paymentAction = PaymentActions.RECOVER_PAYMENT
            } else if paymentResult.status == PaymentStatus.REJECTED.rawValue{
                paymentAction = PaymentActions.SELECTED_OTHER_PM
            } else if cellName == "rejected" {
                paymentAction = PaymentActions.RECOVER_PAYMENT
            } else {
                paymentAction = PaymentActions.RECOVER_TOKEN
            }
            MPTracker.trackEvent(MercadoPagoContext.sharedInstance, screen: self.getLayoutName(), action: paymentAction.rawValue, result: nil)
            self.callback(status)
        }
        return callbackWithTracker
    }
    enum PaymentStatus : String {
        case APPROVED = "approved"
        case REJECTED = "rejected"
        case RECOVERY = "recovery"
        case IN_PROCESS = "in_process"
    }
    enum PaymentActions : String {
        case RECOVER_PAYMENT = "RECOVER_PAYMENT"
        case RECOVER_TOKEN = "RECOVER_TOKEN"
        case SELECTED_OTHER_PM = "SELECT_OTHER_PAYMENT_METHOD"
    }
    
    func isHeaderCellFor(indexPath: IndexPath) -> Bool {
        return indexPath.section == 0
    }
    
    func isFooterCellFor(indexPath: IndexPath) -> Bool {
        return indexPath.section == 3
    }
    
    func isApprovedBodyCellFor(indexPath: IndexPath) -> Bool {
        return indexPath.section == 1 && indexPath.row == 0 && approved()
    }
    
    func isEmailCellFor(indexPath: IndexPath) -> Bool {
        return indexPath.section == 1 && indexPath.row == 1 && approved()
    }
    
    func isCallForAuthFor(indexPath: IndexPath) -> Bool {
        return indexPath.section == 1 && indexPath.row == 0 && callForAuth()
    }
    func isSelectOtherPaymentMethodCellFor(indexPath: IndexPath) -> Bool {
        return !MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isSelectAnotherPaymentMethodDisable() && indexPath.section == 1 && (rejected() || inProcess() || (indexPath.row == 1 && callForAuth()))
    }
    
    func isAdditionalCustomCellFor(indexPath: IndexPath) -> Bool {
        return indexPath.section == 2
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if section == 1 {
            return numberOfCellInBody()
        } else if section == 2 {
            return numberOfCustomAdditionalCells()
        }
        return 1
    }
    
    func numberOfCellInBody() -> Int {
        let selectAnotherCell = !MercadoPagoCheckoutViewModel.paymentResultScreenPreference.isSelectAnotherPaymentMethodDisable() ? 1 : 0
        if approved() {
            return !String.isNullOrEmpty(paymentResult.payerEmail) ? 2 : 1
            
        } else if callForAuth() {
            return selectAnotherCell + 1
        }
        
        return selectAnotherCell
    }
    
    func numberOfCustomAdditionalCells() -> Int {
        if !Array.isNullOrEmpty(PaymentResultScreenPreference.pendingAdditionalInfoCells) && inProcess(){
            return PaymentResultScreenPreference.pendingAdditionalInfoCells.count
        } else if !Array.isNullOrEmpty(PaymentResultScreenPreference.approvedAdditionalInfoCells) && approved() {
            return PaymentResultScreenPreference.approvedAdditionalInfoCells.count
        }
        return 0
    }
}

