//
//  CardFormViewController.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 1/18/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class CardFormViewController: MercadoPagoUIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    var bundle: NSBundle? = MercadoPago.getBundle()

    @IBOutlet weak var promoButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    var cardViewBack: UIView?

    var cardFront: CardFrontView?
    var cardBack: CardBackView?

    var cardNumberLabel: UILabel?
    var numberLabelEmpty: Bool = true
    var nameLabel: UILabel?
    var nameLabelEmpty: Bool = true
    var expirationDateLabel: UILabel?
    var expirationLabelEmpty: Bool = true
    var cvvLabel: UILabel?
    var cvvLabelEmpty: Bool = true

    var editingLabel: UILabel?
    @IBOutlet weak var textBox: UITextField!

    var paymentMethods: [PaymentMethod]?
    var paymentMethod: PaymentMethod?

    var paymentType: PaymentType?
    var callback : (( paymentMethod: PaymentMethod, token: Token?, issuer: Issuer?, installment: Installment?) -> Void)?

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public init(paymentType: PaymentType?, callback : ((paymentMethod: PaymentMethod, token: Token?, issuer: Issuer?, installment: Installment?) -> Void)) {
        super.init(nibName: "CardFormViewController", bundle: self.bundle)
        self.paymentType = paymentType
        self.edgesForExtendedLayout = .All
        self.callback = callback
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public override func viewWillAppear(animated: Bool) {
        cardView.addSubview(cardFront!)
        updateLabelsFontColors()

    }

    public override func viewDidAppear(animated: Bool) {
        cardFront?.frame = cardView.bounds
        cardBack?.frame = cardView.bounds
        textBox.placeholder = "Numero".localized
        textBox.becomeFirstResponder()

        MPServicesBuilder.getPaymentMethods({ (paymentMethods) -> Void in
            self.paymentMethods = paymentMethods
            }) { (_) -> Void in
                // Mensaje de error correspondiente, ver que hacemos con el flujo
        }
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        textBox.autocorrectionType = UITextAutocorrectionType.No
         textBox.keyboardType = UIKeyboardType.NumberPad
        textBox.addTarget(self, action: "editingChanged:", forControlEvents: UIControlEvents.EditingChanged)
       setupInputAccessoryView()
        textBox.delegate = self
        cardFront = CardFrontView()
        cardBack = CardBackView()
        cardBack!.backgroundColor = UIColor.clearColor()

        cardNumberLabel = cardFront?.cardNumber
        nameLabel = cardFront?.cardName
        expirationDateLabel = cardFront?.cardExpirationDate
        cvvLabel = cardBack?.cardCVV

        cardNumberLabel!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "touchNumber:"))
        cardNumberLabel?.text = ".... .... .... ...."
        nameLabel!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "touchName:"))
        nameLabel?.text = "Nombre Completo".localized
        expirationDateLabel!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "touchDate:"))
        expirationDateLabel?.text = "MM/AA".localized
        cvvLabel!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "touchCVV:"))
        cvvLabel?.text = "CVV".localized
        editingLabel = cardNumberLabel

    }

    func applyPlainShadow(view: UIView) {
        let layer = view.layer

        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return validateInput(textField, shouldChangeCharactersInRange: range, replacementString: string)
    }

    public func editingChanged(textField: UITextField) {

        if(editingLabel == cardNumberLabel) {
            editingLabel?.text = formatCardNumberText(textField.text!)
            self.updateCardSkin()

            if(isAmexCard()) {
                if (textField.text?.characters.count==18) {
                    self.prepareNameLabelForEdit()
                }
            } else {
                if (textField.text?.characters.count==20) {
                    self.prepareNameLabelForEdit()
                }
            }
             updateLabelsFontColors()
        } else if(editingLabel == nameLabel) {
            editingLabel?.text = formatName(textField.text!)
            if (textField.text?.characters.count==20) {
                self.prepareExpirationLabelForEdit()
            }
             updateLabelsFontColors()
        } else if(editingLabel == expirationDateLabel) {
            editingLabel?.text = formatExpirationDate(textField.text!)
            if(textField.text?.characters.count == 5) {
                if(!isAmexCard()) {
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                    dispatch_after(delayTime, dispatch_get_main_queue()) {
                        self.promoButton.alpha = 0
                        self.promoButton.enabled = false
                        UIView.transitionFromView(self.cardFront!, toView: self.cardBack!, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: { (completion) -> Void in
                            self.prepareCVVLabelForEdit()
                        })
                    }
                } else {
                    self.prepareCVVLabelForEdit()
                }

            }
             updateLabelsFontColors()
        } else {
            editingLabel?.text = formatCVV(textField.text!)

            if(textField.text?.characters.count == 3) {
                if(!isAmexCard()) {
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                    dispatch_after(delayTime, dispatch_get_main_queue()) {

                        UIView.transitionFromView(self.cardBack!, toView: self.cardFront!, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: { (completion) -> Void in
                            self.prepareNumberLabelForEdit()
                            self.promoButton.alpha = 1
                            self.promoButton.enabled = true
                        })

                    }
                } else {
                    self.prepareNumberLabelForEdit()
                }

                closeKeyboard()
                makeToken()
            }

        }

    }

    public func textFieldShouldReturn(textField: UITextField) -> Bool {

        if(editingLabel == nameLabel) {
                self.prepareExpirationLabelForEdit()
        }
        return true
    }

    /* Metodos para formatear el texto ingresado de forma que se muestre
        de forma adecuada dependiendo de cada campo de texto */
    private func formatCardNumberText(numberText: String) -> String {
        if(numberText.characters.count == 0) {
            numberLabelEmpty = true
            return ".... .... .... ...."
        }
        numberLabelEmpty = false
        return numberText
    }

    private func formatName(name: String) -> String {
        if(name.characters.count == 0) {
            nameLabelEmpty = true
            return "Nombre Completo".localized
        }
        nameLabelEmpty = false
        return name.uppercaseString
    }
    private func formatCVV(cvv: String) -> String {
        if(cvv.characters.count == 0) {
            cvvLabelEmpty = true
            return "CVV".localized
        }
        cvvLabelEmpty = false
        return cvv
    }
    private func formatExpirationDate(expirationDate: String) -> String {
        if(expirationDate.characters.count == 0) {
            expirationLabelEmpty = true
            return "MM/AA".localized
        }
        expirationLabelEmpty = false
        return expirationDate
    }

    /* Metodos para preparar los diferentes labels del formulario para ser editados */
    private func prepareNumberLabelForEdit() {
        editingLabel = cardNumberLabel
        textBox.resignFirstResponder()
        textBox.keyboardType = UIKeyboardType.NumberPad
        textBox.becomeFirstResponder()
        textBox.text = numberLabelEmpty ?  "" : cardNumberLabel!.text
        textBox.placeholder = "Numero de tarjeta".localized
    }
    private func prepareNameLabelForEdit() {
        editingLabel = nameLabel
        textBox.resignFirstResponder()
        textBox.keyboardType = UIKeyboardType.Alphabet
        textBox.becomeFirstResponder()
        textBox.text = nameLabelEmpty ?  "" : nameLabel!.text!.stringByReplacingOccurrencesOfString(" ", withString: "")
        textBox.placeholder = "Nombre Completo".localized

    }
    private func prepareExpirationLabelForEdit() {
        editingLabel = expirationDateLabel
        textBox.resignFirstResponder()
        textBox.keyboardType = UIKeyboardType.NumberPad
        textBox.becomeFirstResponder()
        textBox.text = expirationLabelEmpty ?  "" : expirationDateLabel!.text
        textBox.placeholder = "Fecha de Expiracion".localized
    }
    private func prepareCVVLabelForEdit() {
        if(isAmexCard()) {
            cvvLabel = cardFront?.cardCVV
            cardBack?.cardCVV.text = "CVV".localized
            cardBack?.cardCVV.alpha = 0
            cardFront?.cardCVV.alpha = 1
        } else {
            cvvLabel = cardBack?.cardCVV
            cardFront?.cardCVV.text = "CVV".localized
            cardFront?.cardCVV.alpha = 0
            cardBack?.cardCVV.alpha = 1
        }
        editingLabel = cvvLabel
        textBox.resignFirstResponder()
        textBox.keyboardType = UIKeyboardType.NumberPad
        textBox.becomeFirstResponder()
        textBox.text = cvvLabelEmpty  ?  "" : cvvLabel!.text!.stringByReplacingOccurrencesOfString(" ", withString: "")
        textBox.placeholder = "Codigo de Seguridad".localized
    }

    /* Metodos para escucha de los touch sobre los labels */
    func touchNumber(sender: UITapGestureRecognizer) {
        prepareNumberLabelForEdit()
        updateLabelsFontColors()
    }
    func touchName(sender: UITapGestureRecognizer) {
        prepareNameLabelForEdit()
        updateLabelsFontColors()
    }
    func touchDate(sender: UITapGestureRecognizer) {
        prepareExpirationLabelForEdit()
        updateLabelsFontColors()
    }
    func touchCVV(sender: UITapGestureRecognizer) {
        prepareCVVLabelForEdit()
        updateLabelsFontColors()
    }

    /* Metodos para validar si un texto ingresado es valido, dependiendo del tipo
        de campo que se este llenando */

    func validateInput(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch editingLabel! {

        case cardNumberLabel! :
            if(isAmexCard()) {
                return validAmexInputNumber(textField, shouldChangeCharactersInRange: range, replacementString: string)
            } else {
                return validInputNumber(textField, shouldChangeCharactersInRange: range, replacementString: string)
            }

        case nameLabel! : return validInputName(textField.text! + string)

        case expirationDateLabel! : return validInputDate(textField, shouldChangeCharactersInRange: range, replacementString: string)

        case cvvLabel! : return validInputCVV(textField.text! + string)
        default : return false
        }
    }

    func validInputNumber(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        //Range.Lenth will greater than 0 if user is deleting text - Allow it to replce
        if range.length > 0 {
            return true
        }

        //Dont allow empty strings
        if string == " " {
            return false
        }

        //Check for max length including the spacers we added
        if range.location == 20 {
            return false
        }

        var originalText = textField.text
        let replacementText = string.stringByReplacingOccurrencesOfString(" ", withString: "")

        //Verify entered text is a numeric value
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        for char in replacementText.unicodeScalars {
            if !digits.longCharacterIsMember(char.value) {
                return false
            }
        }

        //Put an empty space after every 4 places
        if originalText!.characters.count % 5 == 0 {
            originalText?.appendContentsOf(" ")
            textField.text = originalText
        }

        return true

    }
    func validAmexInputNumber(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        //Range.Lenth will greater than 0 if user is deleting text - Allow it to replce
        if range.length > 0 {
            return true
        }

        //Dont allow empty strings
        if string == " " {
            return false
        }

        //Check for max length including the spacers we added
        if range.location == 18 {
            return false
        }

        var originalText = textField.text
        let replacementText = string.stringByReplacingOccurrencesOfString(" ", withString: "")

        //Verify entered text is a numeric value
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        for char in replacementText.unicodeScalars {
            if !digits.longCharacterIsMember(char.value) {
                return false
            }
        }

        if ((originalText!.characters.count == 4)||(originalText!.characters.count == 12)) {
            originalText?.appendContentsOf(" ")
            textField.text = originalText
        }

        return true

    }

    func validInputName(text: String) -> Bool {
        return true
    }
    func validInputDate(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //Range.Lenth will greater than 0 if user is deleting text - Allow it to replce
        if range.length > 0 {
            return true
        }

        //Dont allow empty strings
        if string == " " {
            return false
        }

        //Check for max length including the spacers we added
        if range.location == 5 {
            return false
        }

        var originalText = textField.text
        let replacementText = string.stringByReplacingOccurrencesOfString("/", withString: "")

        //Verify entered text is a numeric value
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        for char in replacementText.unicodeScalars {
            if !digits.longCharacterIsMember(char.value) {
                return false
            }
        }

        if originalText!.characters.count == 2 {
            originalText?.appendContentsOf("/")
            textField.text = originalText
        }

        return true

    }

    func validInputCVV(text: String) -> Bool {
        if( text.characters.count > self.cvvLenght() ) {
            return false
        }
        let num = Int(text)
        return (num != nil)
    }

    func cvvLenght() -> Int {
        var lenght: Int

        if ((paymentMethod?.settings == nil)||(paymentMethod?.settings.count == 0)) {
            lenght = 3 // Default
        } else {
            lenght = (paymentMethod?.settings[0].securityCode.length)!
        }
        return lenght
    }

    func setupInputAccessoryView() {
        let navBar = UINavigationBar(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 44))
        navBar.barStyle = UIBarStyle.Default
        navBar.backgroundColor = UIColor(netHex: 0xEEEEEE)
        navBar.alpha = 1
        //replace viewWidth with view controller width
        let navItem = UINavigationItem()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "closeKeyboard")

      //  let doneNext = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "rightArrowKeyTapped")
     //   let donePrev = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Rewind, target: self, action: "leftArrowKeyTapped")

       let doneNext =  UIBarButtonItem(image: MercadoPago.getImage("right_arrow"), landscapeImagePhone: MercadoPago.getImage("right_arrow"), style: .Plain, target: self, action: "rightArrowKeyTapped")
        let donePrev = UIBarButtonItem(image: MercadoPago.getImage("left_arrow"), landscapeImagePhone: MercadoPago.getImage("left_arrow"), style: .Plain, target: self, action: "leftArrowKeyTapped")

        navItem.rightBarButtonItem = doneButton

        navItem.setLeftBarButtonItems([donePrev, doneNext], animated: false)

        navBar.pushNavigationItem(navItem, animated: false)

        textBox.inputAccessoryView = navBar

    }

    func leftArrowKeyTapped() {
        switch editingLabel! {

        case cardNumberLabel! :
            self.promoButton.alpha = 0
            self.promoButton.enabled = false
            UIView.transitionFromView(self.cardFront!, toView: self.cardBack!, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
            self.prepareCVVLabelForEdit()

        case nameLabel! :
            self.prepareNumberLabelForEdit()
        case expirationDateLabel! :
        prepareNameLabelForEdit()

        case cvvLabel! :

            UIView.transitionFromView(self.cardBack!, toView: self.cardFront!, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: { (completion) -> Void in
                self.promoButton.alpha = 1
                self.promoButton.enabled = true
            })

            prepareExpirationLabelForEdit()
        default : return
        }

    }
    func rightArrowKeyTapped() {
        switch editingLabel! {

        case cardNumberLabel! : prepareNameLabelForEdit()

        case nameLabel! : prepareExpirationLabelForEdit()

        case expirationDateLabel! :
            if(!isAmexCard()) {
                self.promoButton.alpha = 0
                self.promoButton.enabled = false
               UIView.transitionFromView(self.cardFront!, toView: self.cardBack!, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
            }

            self.prepareCVVLabelForEdit()

        case cvvLabel! :
            if(!isAmexCard()) {
                UIView.transitionFromView(self.cardBack!, toView: self.cardFront!, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: { (completion) -> Void in
                    self.promoButton.alpha = 1
                    self.promoButton.enabled = true
                })
            }

            self.prepareNumberLabelForEdit()
        default : return
        }
    }

    func closeKeyboard() {
        textBox.resignFirstResponder()
        delightedLabels()
    }

    func getBIN() -> String? {
        if(numberLabelEmpty) {
            return nil
        }
        let trimmedNumber = cardNumberLabel?.text?.stringByReplacingOccurrencesOfString(" ", withString: "")

        if (trimmedNumber!.characters.count < 6) {
            return nil
        } else {
            let bin = trimmedNumber!.substringToIndex((trimmedNumber?.startIndex.advancedBy(6))!)
            return bin
        }
    }

    func matchedPaymentMethod () -> PaymentMethod? {
        if(paymentMethods == nil) {
            return nil
        }
        if(getBIN() == nil) {
            return nil
        }
        for (_, value) in paymentMethods!.enumerate() {
            if (paymentType != nil) {
                if (value.paymentTypeId == paymentType?.paymentTypeId) {
                    if (value.conformsToBIN(getBIN()!)) {
                        return value.cloneWithBIN(getBIN()!)
                    }
                }
            } else {
                if (value.conformsToBIN(getBIN()!)) {
                    return value.cloneWithBIN(getBIN()!)
                }
            }

        }
        return nil
    }

    func clearCardSkin() {

        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.cardFront?.cardLogo.alpha =  0
            self.cardView.backgroundColor = UIColor(netHex: 0xEEEEEE)
            }) { (_) -> Void in
                self.cardFront?.cardLogo.image =  nil

        }

    }
    func updateCardSkin() {
        if (textBox.text?.characters.count>7) {
            paymentMethod = self.matchedPaymentMethod()
            if(paymentMethod != nil) {
                UIView.animateWithDuration(0.7, animations: { () -> Void in
               self.cardFront?.cardLogo.image =  MercadoPago.getImageFor(self.paymentMethod!)
                    self.cardView.backgroundColor = MercadoPago.getColorFor(self.paymentMethod!)
                    self.cardFront?.cardLogo.alpha = 1
                })

            } else {
                self.clearCardSkin()
            }
        } else {
            self.clearCardSkin()
        }

        if((paymentMethod != nil)&&(!paymentMethod!.secCodeInBack())) {
            cvvLabel = cardFront?.cardCVV
            cardBack?.cardCVV.text = ""
        } else {
            cvvLabel = cardBack?.cardCVV
            cardFront?.cardCVV.text = ""
        }
    }

    func isAmexCard() -> Bool {
        if(getBIN() == nil) {
            return false
        }
        if(paymentMethod != nil) {
            return paymentMethod!.isAmex()
        } else {
            return false
        }
    }

    let defaultColorText = UIColor(netHex:0x333333)
    let highlightedColorText = UIColor(netHex:0x999999)
    let errorColorText = UIColor(netHex:0xFF0000)

    func delightedLabels() {
         cardNumberLabel?.textColor = defaultColorText
         nameLabel?.textColor = defaultColorText
         expirationDateLabel?.textColor = defaultColorText
         cvvLabel?.textColor = defaultColorText
    }

    func lightEditingLabel() {
        editingLabel?.textColor = highlightedColorText
    }
    func updateLabelsFontColors() {
        self.delightedLabels()
        self.lightEditingLabel()
    }
    func markErrorLabel(label: UILabel) {
        label.textColor = errorColorText
    }

    func makeToken() {
        let number =  numberLabelEmpty ? "" :cardNumberLabel?.text
        let month = getMonth()
        let year = getYear()
        let secCode = cvvLabel?.text
        let name = nameLabel?.text

        let cardtoken = CardToken(cardNumber: number, expirationMonth: month, expirationYear: year, securityCode: secCode, cardholderName: name!, docType: "", docNumber: "")

        if (paymentMethod != nil) {
            let errorMethod = cardtoken.validateCardNumber(paymentMethod!)
            if((errorMethod) != nil) {
                markErrorLabel(cardNumberLabel!)
                return
            }
        } else {
            let errorNumber = cardtoken.validateCardNumber()
            if((errorNumber) != nil) {
                markErrorLabel(cardNumberLabel!)
                return
            }
        }

        let errorDate = cardtoken.validateExpiryDate()
        if((errorDate) != nil) {
            markErrorLabel(expirationDateLabel!)
            return
        }
        let errorName = cardtoken.validateCardholderName()
        if((errorName) != nil) {
            markErrorLabel(nameLabel!)
            return
        }
        let errorCVV = cardtoken.validateSecurityCode()
        if((errorCVV) != nil) {
            markErrorLabel(cvvLabel!)
            self.promoButton.alpha = 0
            self.promoButton.enabled = false
            UIView.transitionFromView(self.cardBack!, toView: self.cardFront!, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
            return
        }

        MPServicesBuilder.createNewCardToken(cardtoken, success: { (token) -> Void in
            //self.callback!((token: token, paymentMethod: self.paymentMethod! ,issuer:nil, installment: nil))
            self.callback!(paymentMethod: self.paymentMethod!, token: token!, issuer:nil, installment: nil)
            }) { (_) -> Void in
                print("Falla!")
        }
    }

    func getMonth() -> Int {
        let stringMMYY = expirationDateLabel?.text?.stringByReplacingOccurrencesOfString("/", withString: "")
        let validInt = Int(stringMMYY!)
        if(validInt == nil) {
            return 0
        }
        let floatMMYY = Float(validInt! / 100)
        let mm: Int = Int(floor(floatMMYY))
        return mm
    }
    func getYear() -> Int {
        let stringMMYY = expirationDateLabel?.text?.stringByReplacingOccurrencesOfString("/", withString: "")
        let validInt = Int(stringMMYY!)
        if(validInt == nil) {
            return 0
        }
        let floatMMYY = Float( validInt! / 100 )
        let mm: Int = Int(floor(floatMMYY))
        let yy = Int(stringMMYY!)! - (mm*100)
        return yy
    }

    //BUTTON 
    func configureButton() {

       // promoButton.titleLabel!.font =  UIFont.boldSystemFontOfSize(8)
      //  promoButton.titleLabel!.text = "VER BANCOS CON MSI"
        promoButton.backgroundColor = UIColor.whiteColor()
        promoButton.layer.cornerRadius = 0.5 * promoButton.bounds.size.width
        promoButton.layer.borderColor = UIColor(netHex: 0x359FDB).CGColor
        promoButton.layer.borderWidth = 2.0
        promoButton.clipsToBounds = true
    }

    override public func viewDidLayoutSubviews() {
        configureButton()
    }

}
