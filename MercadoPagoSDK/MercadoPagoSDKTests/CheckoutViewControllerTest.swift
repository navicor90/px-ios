//
//  CheckoutViewControllerTest.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 22/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import XCTest
@testable import MercadoPagoSDK

class CheckoutViewControllerTest: BaseTest {
    
    var checkoutViewController : MockCheckoutViewController?
    var preference : CheckoutPreference?
    var selectedPaymentMethod : PaymentMethod?
    var selectedPayerCost : PayerCost?
    var selectedIssuer : Issuer?
    var createdToken : Token?
    
    override func setUp() {
        super.setUp()
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_NO_EXCLUSIONS, callback: { (payment) in
            
        })
        

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitParameters() {
        
        XCTAssertEqual(checkoutViewController!.preferenceId, MockBuilder.PREF_ID_NO_EXCLUSIONS)
        XCTAssertEqual(checkoutViewController!.publicKey, MercadoPagoContext.publicKey())
        XCTAssertEqual(checkoutViewController!.accessToken, MercadoPagoContext.merchantAccessToken())
        XCTAssertNil(checkoutViewController!.viewModel!.paymentMethod)
    }
    
    func testSetupCheckoutWithPreference(){
        
        MPServicesBuilder.getPreference(MockBuilder.PREF_ID_NO_EXCLUSIONS, success: { (preference) in
            self.preference = preference
        }) { (error) in
            
        }
        
        waitForExpectationsWithTimeout(BaseTest.WAIT_EXPECTATION_TIME_INTERVAL, handler: nil)
        // Cargar vista
        self.simulateViewDidLoadFor(self.checkoutViewController!)
        
        // Verificar preferencia
        XCTAssertEqual(self.preference?._id, self.checkoutViewController!.preference?._id)
        
        // Verificar atributos iniciales de pantalla
        checkInitialScreenAttributes()
      
    }
    
    
    /*
     *  Todos los medios de pago disponibles.
     *  Se selecciona medio off para pago.
     *  Última pantalla es instrucciones de pago
     */
    func testCheckoutMLA_preferenceWithNoExclusionsPaymentOff(){
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_NO_EXCLUSIONS, callback: { (payment : Payment) in
            
            
        })
        
        // Metodo de pago no seleccionado
        XCTAssertNil(checkoutViewController?.viewModel!.paymentMethod)
        
        self.simulateViewDidLoadFor(checkoutViewController!)
        
        let navigationController = UINavigationController(rootViewController: self.checkoutViewController!)
        
        XCTAssertNotNil(checkoutViewController?.viewModel!.paymentMethodSearch)
        XCTAssertTrue(checkoutViewController?.viewModel!.paymentMethodSearch?.groups.count == MockBuilder.MLA_PAYMENT_TYPES.count)
        
        // Verificar selección de medio off
        verifyPaymentVaultSelection_paymentMethodOff("rapipago")
        
        
        // Pago con medio off
        verifyConfirmPaymentOff()
        
        // Verificar que ultima pantalla sea instrucciones de pago
        let lastViewController = self.checkoutViewController!.navigationController?.viewControllers.last
        XCTAssertNotNil(lastViewController)
        //XCTAssertTrue(lastViewController!.isKindOfClass(InstructionsViewController))
        
        
        //Verificar payment method id seleccionado en instrucciones
        //let instructionsVC = (lastViewController as! InstructionsViewController)
        //XCTAssertEqual(instructionsVC.payment.paymentMethodId, self.selectedPaymentMethod?._id)
        
    }
    
    /*
     *  Todos los medios de pago disponible.
     *  Se selecciona cc para pago.
     *  Última pantalla es congrats
     */
    func testCheckoutMLA_preferenceWithNoExclusionsPaymentCreditCard(){
        
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_NO_EXCLUSIONS, callback: { (payment : Payment) in
            
        })
        
        // Metodo de pago no seleccionado
        XCTAssertNil(checkoutViewController?.viewModel!.paymentMethod)
        
        self.checkoutViewController = self.simulateViewDidLoadFor(checkoutViewController!) as! MockCheckoutViewController
        
        let navigationController = UINavigationController(rootViewController: self.checkoutViewController!)
        
        XCTAssertNotNil(checkoutViewController?.viewModel!.paymentMethodSearch)
        XCTAssertTrue(checkoutViewController?.viewModel!.paymentMethodSearch?.groups.count == MockBuilder.MLA_PAYMENT_TYPES.count)
        
        // Pago con tarjeta de crédito
        verifyPaymentVaultSelection_creditCard()
        
        verifyConfirmPaymentCC()
        
        // Verificar que ultima pantalla sea de pago aprobado
        let lastViewController = self.checkoutViewController!.navigationController?.viewControllers.last
        XCTAssertNotNil(lastViewController)
     //   XCTAssertTrue(lastViewController!.isKindOfClass(PaymentCongratsViewController))
        
        //Verificar payment method id seleccionado en instrucciones
     //   let congrats = (lastViewController as! PaymentCongratsViewController)
        //XCTAssertEqual(congrats.payment.paymentMethodId, self.selectedPaymentMethod?._id)
        
        
    }
    
    
    /*
     *  Solo pago con CC disponible.
     *  Se selecciona cc para pago.
     *  Última pantalla es congrats
     */
    func testCheckoutMLA_preferenceOnlyCCPaymentCreditCard(){
        
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_CC, callback: { (payment : Payment) in
            
        })
        
        
        // Metodo de pago no seleccionado
        XCTAssertNil(checkoutViewController?.viewModel!.paymentMethod)
        
        self.simulateViewDidLoadFor(checkoutViewController!)
        
        let navigationController = UINavigationController(rootViewController: self.checkoutViewController!)
        
        // Solo tarjeta de crédito disponible
        XCTAssertNotNil(checkoutViewController?.viewModel!.paymentMethodSearch)
        let excludedPaymentTypeIds = Set([PaymentTypeId.TICKET.rawValue, PaymentTypeId.BANK_TRANSFER.rawValue])
        let availablePaymentTypes = MockBuilder.MLA_PAYMENT_TYPES.subtract(excludedPaymentTypeIds)
        XCTAssertTrue(checkoutViewController?.viewModel!.paymentMethodSearch?.groups.count == availablePaymentTypes.count)
        
        // Pago con tarjeta de crédito
        verifyPaymentVaultSelection_creditCard()
        
        // Verificar cantidad de celdas en pantalla
        let numberOfRows = self.checkoutViewController?.tableView(self.checkoutViewController!.checkoutTable, numberOfRowsInSection: 1)
        XCTAssertEqual(numberOfRows, 4)
        
        // Crear pago con tarjeta
        verifyConfirmPaymentCC()
        
        // Verificar que ultima pantalla sea de pago aprobado
        let lastViewController = self.checkoutViewController!.navigationController?.viewControllers.last
        XCTAssertNotNil(lastViewController)
       // XCTAssertTrue(lastViewController!.isKindOfClass(PaymentCongratsViewController))
        
        
        //Verificar payment method id seleccionado en instrucciones
    //    let congrats = (lastViewController as! PaymentCongratsViewController)
        //XCTAssertEqual(congrats.payment.paymentMethodId, self.selectedPaymentMethod?._id)
        
        
    }
    
    
    
    /*
     *  Solo pago con ticket disponible.
     *  Se selecciona pagofacil para pago.
     *  Última pantalla es instrucciones
     */
    func testCheckoutMLA_preferenceOnlyTicketPaymentOff(){
        
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_TICKET, callback: { (payment : Payment) in
            
        })
        
        // Metodo de pago no seleccionado
        XCTAssertNil(checkoutViewController?.viewModel!.paymentMethod)
        
        self.simulateViewDidLoadFor(checkoutViewController!)
        
        let navigationController = UINavigationController(rootViewController: self.checkoutViewController!)
        
        // Solo medios off disponibles
        XCTAssertNotNil(checkoutViewController?.viewModel!.paymentMethodSearch)
        // Solo ticket disponible
        XCTAssertTrue(checkoutViewController?.viewModel!.paymentMethodSearch?.groups.count == 1)
        XCTAssertNotNil(checkoutViewController!.viewModel!.paymentMethodSearch!.groups[0].children)
        XCTAssertTrue(checkoutViewController?.viewModel!.paymentMethodSearch?.groups[0].children.count == 3)
        
        // Seleccionar método de pago
        verifyPaymentVaultSelection_paymentMethodOff("pagofacil")
        
        // Verificar cantidad de celdas en pantalla
        let numberOfRows = self.checkoutViewController?.tableView(self.checkoutViewController!.checkoutTable, numberOfRowsInSection: 1)
        XCTAssertEqual(numberOfRows, 3)
        
        // Crear pago
        verifyConfirmPaymentOff()
        
        // Verificar que ultima pantalla sea de pago aprobado
        let lastViewController = self.checkoutViewController!.navigationController?.viewControllers.last
        XCTAssertNotNil(lastViewController)
     //   XCTAssertTrue(lastViewController!.isKindOfClass(InstructionsViewController))
        
        
        //Verificar payment method id seleccionado en instrucciones
    //    let instructions = (lastViewController as! InstructionsViewController)
    //    XCTAssertEqual(instructions.payment.paymentMethodId, self.selectedPaymentMethod?._id)
        
        
    }
    
    
    /*
     *  Solo pago disponible con rapipago.
     *  Última pantalla es instrucciones de rapipago.
     */
    func testCheckoutMLA_preferenceOnlyPagoFacilPaymentMethodOff(){
        
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_PAGOFACIL, callback: { (payment : Payment) in
            
        })
        
        // Metodo de pago no seleccionado
        XCTAssertNil(checkoutViewController?.viewModel!.paymentMethod)
        
        self.simulateViewDidLoadFor(checkoutViewController!)
        let navigationController = UINavigationController(rootViewController: self.checkoutViewController!)
        
        // Solo pagofacil disponible
        XCTAssertNotNil(checkoutViewController?.viewModel!.paymentMethodSearch)
        XCTAssertTrue(checkoutViewController?.viewModel!.paymentMethodSearch?.groups.count == 1)
        
        // Seleccionar método de pago
        verifyPaymentVaultSelection_paymentMethodOff("pagofacil")
        
        // Verificar cantidad de celdas en pantalla
        let numberOfRows = self.checkoutViewController?.tableView(self.checkoutViewController!.checkoutTable, numberOfRowsInSection: 1)
        XCTAssertEqual(numberOfRows, 3)
        
        // Crear pago con pagofacil
        verifyConfirmPaymentOff()
        
        // Verificar que ultima pantalla sea de pago aprobado
        let lastViewController = self.checkoutViewController!.navigationController?.viewControllers.last
        XCTAssertNotNil(lastViewController)
      //  XCTAssertTrue(lastViewController!.isKindOfClass(InstructionsViewController))
        
        
        //Verificar payment method id seleccionado en instrucciones
    //    let instructions = (lastViewController as! InstructionsViewController)
    //    XCTAssertEqual(instructions.payment.paymentMethodId, self.selectedPaymentMethod?._id)
        
        
    }
    
    /*
     *  Todos los medios de pago disponible.
     *  Se selecciona cc para pago.
     *  Última pantalla es congrats
     */
    func testCheckoutMLA_preferenceSet(){
        
        let preference = MockBuilder.buildCheckoutPreference()
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_NO_EXCLUSIONS, callback: { (payment : Payment) in

        })
        self.checkoutViewController?.preference = preference
        
        // Metodo de pago no seleccionado
        XCTAssertNil(checkoutViewController?.viewModel!.paymentMethod)
        
        self.checkoutViewController = self.simulateViewDidLoadFor(checkoutViewController!) as! MockCheckoutViewController
        
        let navigationController = UINavigationController(rootViewController: self.checkoutViewController!)
        
        XCTAssertNotNil(checkoutViewController?.viewModel!.paymentMethodSearch)
        XCTAssertTrue(checkoutViewController?.viewModel!.paymentMethodSearch?.groups.count == MockBuilder.MLA_PAYMENT_TYPES.count)
        
        // Pago con tarjeta de crédito
        verifyPaymentVaultSelection_creditCard()
        
        verifyConfirmPaymentCC()
        
        // Verificar que ultima pantalla sea de pago aprobado
        let lastViewController = self.checkoutViewController!.navigationController?.viewControllers.last
        XCTAssertNotNil(lastViewController)
        //   XCTAssertTrue(lastViewController!.isKindOfClass(PaymentCongratsViewController))
        
        //Verificar payment method id seleccionado en instrucciones
        //   let congrats = (lastViewController as! PaymentCongratsViewController)
        //XCTAssertEqual(congrats.payment.paymentMethodId, self.selectedPaymentMethod?._id)
        
        
    }
    
    func testNumberOfSections(){
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_NO_EXCLUSIONS, callback: { (payment : Payment) in
            
        })
        self.simulateViewDidLoadFor(self.checkoutViewController!)
        let numberOfSections = self.checkoutViewController?.numberOfSectionsInTableView(self.checkoutViewController!.checkoutTable)
        XCTAssertTrue(numberOfSections == 0)
        
        self.checkoutViewController?.viewModel!.paymentMethod = MockBuilder.buildPaymentMethod("amex")
    }
    
    
    
    func verifyPaymentVaultSelection_paymentMethodOff(paymentMethodId : String){
        
        self.selectedPaymentMethod = Utils.findPaymentMethod((self.checkoutViewController?.viewModel!.paymentMethodSearch!.paymentMethods)!, paymentMethodId: paymentMethodId)
        
        // Selección de medio off
        checkoutViewController?.navigationController?.popViewControllerAnimated(true)
        checkoutViewController?.paymentVaultCallback(selectedPaymentMethod!, token: nil, issuer: nil, payerCost: nil)
        
     //   XCTAssertEqual(checkoutViewController?.paymentMethod, selectedPaymentMethod)
    
    }
    
    
    func verifyPaymentVaultSelection_creditCard(){
        
        self.selectedPaymentMethod = Utils.findPaymentMethod((self.checkoutViewController?.viewModel!.paymentMethodSearch!.paymentMethods)!, paymentMethodId: "visa")
        self.selectedPayerCost = MockBuilder.buildPayerCost()
        self.selectedIssuer = MockBuilder.buildIssuer()
        self.createdToken = MockBuilder.buildToken()
        
        // Selección Tarjeta
        checkoutViewController?.paymentVaultCallback(selectedPaymentMethod!, token: self.createdToken, issuer: self.selectedIssuer, payerCost: self.selectedPayerCost)
        
        XCTAssertEqual(checkoutViewController?.viewModel!.paymentMethod, selectedPaymentMethod)
        XCTAssertEqual(checkoutViewController?.payerCost, self.selectedPayerCost)
        XCTAssertEqual(checkoutViewController?.issuer, self.selectedIssuer)
        XCTAssertEqual(checkoutViewController?.token, self.createdToken)
        
    }
    
    func checkInitialScreenAttributes(){
        // Verificar descripción de compra
        XCTAssertTrue(checkoutViewController!.displayPreferenceDescription)
        
        let sections = checkoutViewController?.numberOfSectionsInTableView((checkoutViewController?.checkoutTable)!)
        XCTAssertEqual(sections, 0)

        
    }
    
    func testDisplayPaymentResult(){
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_NO_EXCLUSIONS, callback: { (payment : Payment) in
            
        })
        let nav = UINavigationController(rootViewController: self.checkoutViewController!)
        var payment = MockBuilder.buildVisaPayment()
        self.checkoutViewController?.viewModel = CheckoutViewModel()
        self.checkoutViewController!.viewModel?.paymentMethod = MockBuilder.buildPaymentMethod("visa")
        checkoutViewController?.displayPaymentResult(payment)
        
        self.checkoutViewController!.navigationController
        payment = MockBuilder.buildOffPayment("rapipago")
        self.checkoutViewController!.viewModel?.paymentMethod = MockBuilder.buildPaymentMethod("rapipago")
        checkoutViewController?.displayPaymentResult(payment)
    }
    
    func testDrawOfflinePaymentMethodTable() {
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_NO_EXCLUSIONS, callback: { (payment : Payment) in
            
        })
        let nav = UINavigationController(rootViewController: self.checkoutViewController!)
        self.simulateViewDidLoadFor(self.checkoutViewController!)
        self.checkoutViewController!.registerAllCells()
        self.checkoutViewController!.viewModel?.paymentMethod = MockBuilder.buildPaymentMethod("rapipago")
        
        let offlinePaymentCell = self.checkoutViewController!.drawOfflinePaymentMethodTable(NSIndexPath(forRow: 0, inSection: 1)) as! OfflinePaymentMethodCell
        //offlinePaymentCell.comment
        
        let paymentDescriptionCell = self.checkoutViewController!.drawOfflinePaymentMethodTable(NSIndexPath(forRow: 1, inSection: 1)) as! PaymentDescriptionFooterTableViewCell
       
        let termsAndConditionsCell = self.checkoutViewController!.drawOfflinePaymentMethodTable(NSIndexPath(forRow: 2, inSection: 1)) as! TermsAndConditionsViewCell
        
    }
    
    func testDrawCreditCardTable() {
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_NO_EXCLUSIONS, callback: { (payment : Payment) in
            
        })
        let nav = UINavigationController(rootViewController: self.checkoutViewController!)
        self.simulateViewDidLoadFor(self.checkoutViewController!)
        self.checkoutViewController!.registerAllCells()
        self.checkoutViewController!.token = MockBuilder.buildToken()
        self.checkoutViewController!.payerCost = MockBuilder.buildPayerCost()
        self.checkoutViewController!.viewModel?.paymentMethod = MockBuilder.buildPaymentMethod("visa")
        let paymentSearchCell = self.checkoutViewController!.drawCreditCardTable(NSIndexPath(forRow: 0, inSection: 1)) as! PaymentMethodSelectedTableViewCell
        //paymentSearchCell
        
        let installmentsCell = self.checkoutViewController!.drawCreditCardTable(NSIndexPath(forRow: 1, inSection: 1)) as! InstallmentSelectionTableViewCell
        //installmentsCell
        
        let payerCostFooter = self.checkoutViewController!.drawCreditCardTable(NSIndexPath(forRow: 2, inSection: 1)) as! PaymentDescriptionFooterTableViewCell
        
        let termsAndConditionsButton = self.checkoutViewController!.drawCreditCardTable(NSIndexPath(forRow: 3, inSection: 1)) as! TermsAndConditionsViewCell
        
        
    }
    
    func testStartPayerCostStep(){
        self.checkoutViewController = MockCheckoutViewController(preferenceId: MockBuilder.PREF_ID_NO_EXCLUSIONS, callback: { (payment : Payment) in
            
        })
        let nav = UINavigationController(rootViewController: self.checkoutViewController!)
        self.checkoutViewController?.viewModel!.paymentMethod = MockBuilder.buildPaymentMethod("visa")
        self.checkoutViewController!.token = MockBuilder.buildToken()
        self.checkoutViewController!.preference = MockBuilder.buildCheckoutPreference()
        self.checkoutViewController!.startPayerCostStep()

        //self.checkoutViewController?.navigationController!.viewControllers
    }
    
    
    
    func verifyConfirmPaymentOff() {
        
        let termsAndConditionsCell = checkoutViewController!.tableView(checkoutViewController!.checkoutTable, cellForRowAtIndexPath: NSIndexPath(forRow: 2, inSection: 1)) as! TermsAndConditionsViewCell
        XCTAssertNotNil(termsAndConditionsCell)
        let paymentButton = termsAndConditionsCell.paymentButton
        
        // Verificar que este disponible botón de pago y pagar
        XCTAssertTrue(paymentButton.enabled.boolValue)
        self.checkoutViewController!.confirmPayment()
        waitForExpectationsWithTimeout(BaseTest.WAIT_EXPECTATION_TIME_INTERVAL, handler: nil)
        
    }
    
    func verifyConfirmPaymentCC(){
        let termsAndConditionsCell = checkoutViewController!.tableView(checkoutViewController!.checkoutTable, cellForRowAtIndexPath: NSIndexPath(forRow: 3, inSection: 1)) as! TermsAndConditionsViewCell
        XCTAssertNotNil(termsAndConditionsCell)
        let paymentButton = termsAndConditionsCell.paymentButton
        
        XCTAssertTrue(paymentButton.enabled.boolValue)
        self.checkoutViewController!.confirmPayment()
        waitForExpectationsWithTimeout(BaseTest.WAIT_EXPECTATION_TIME_INTERVAL, handler: nil)
    }
    
}

class CheckoutViewModelTest : BaseTest {
    
    var checkoutViewModel : CheckoutViewModel?
    
    func testIsPaymentMethodSelectedCard(){
        self.checkoutViewModel =  CheckoutViewModel()
        
        XCTAssertNil(self.checkoutViewModel!.paymentMethod)
        XCTAssertFalse(self.checkoutViewModel!.isPaymentMethodSelectedCard())
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("master")
        XCTAssertTrue(self.checkoutViewModel!.isPaymentMethodSelectedCard())
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("rapipago", paymentTypeId : "ticket")
        XCTAssertFalse(self.checkoutViewModel!.isPaymentMethodSelectedCard())
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("account_money", paymentTypeId : "account_money")
        XCTAssertFalse(self.checkoutViewModel!.isPaymentMethodSelectedCard())
        
    }
    
    func testNumberOfSections(){
        self.checkoutViewModel =  CheckoutViewModel()
        
        XCTAssertNil(self.checkoutViewModel!.paymentMethod)
        XCTAssertEqual(self.checkoutViewModel!.numberOfSections(), 0)
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("master")
        XCTAssertEqual(self.checkoutViewModel!.numberOfSections(), 2)
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("rapipago", paymentTypeId : "ticket")
        XCTAssertEqual(self.checkoutViewModel!.numberOfSections(), 2)
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("account_money", paymentTypeId : "account_money")
        XCTAssertEqual(self.checkoutViewModel!.numberOfSections(), 2)
        
    }
    
    func testPaymentMethodSelected(){
        self.checkoutViewModel =  CheckoutViewModel()
        
        XCTAssertNil(self.checkoutViewModel!.paymentMethod)
        XCTAssertFalse(self.checkoutViewModel!.isPaymentMethodSelected())
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("master")
        XCTAssertTrue(self.checkoutViewModel!.isPaymentMethodSelected())
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("rapipago", paymentTypeId : "ticket")
        XCTAssertTrue(self.checkoutViewModel!.isPaymentMethodSelected())
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("account_money", paymentTypeId : "account_money")
        XCTAssertTrue(self.checkoutViewModel!.isPaymentMethodSelected())
        
    }
    
    func testNumberOfRowsInMainSection(){
        self.checkoutViewModel =  CheckoutViewModel()
        
        XCTAssertNil(self.checkoutViewModel!.paymentMethod)
        XCTAssertEqual(self.checkoutViewModel?.numberOfRowsInMainSection(), 2)
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("visa")
        XCTAssertEqual(self.checkoutViewModel?.numberOfRowsInMainSection(), 4)
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("rapipago", paymentTypeId : "ticket")
        XCTAssertEqual(self.checkoutViewModel?.numberOfRowsInMainSection(), 3)
        
        self.checkoutViewModel!.paymentMethod = MockBuilder.buildPaymentMethod("account_money", paymentTypeId : "account_money")
        XCTAssertEqual(self.checkoutViewModel?.numberOfRowsInMainSection(), 3)
    }
    
    func testisUniquePaymentMethodAvailable(){
        self.checkoutViewModel =  CheckoutViewModel()
        XCTAssertFalse(self.checkoutViewModel!.isUniquePaymentMethodAvailable())
        
        let paymentMethodSearch = PaymentMethodSearch()
        paymentMethodSearch.paymentMethods = [MockBuilder.buildPaymentMethod("payment_method")]
        self.checkoutViewModel?.paymentMethodSearch = paymentMethodSearch
        XCTAssertTrue(self.checkoutViewModel!.isUniquePaymentMethodAvailable())
        
        paymentMethodSearch.paymentMethods = [MockBuilder.buildPaymentMethod("payment_method")]
        self.checkoutViewModel?.paymentMethodSearch = paymentMethodSearch
        
        
        
    }
}
