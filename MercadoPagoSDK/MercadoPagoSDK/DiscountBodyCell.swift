//
//  DiscountBodyCell.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 1/5/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

class DiscountBodyCell: UIView {

   // @IBOutlet weak var viewTitle: UILabel!
    
    @IBOutlet weak var discountTitle: UILabel!
 //   @IBOutlet weak var discountAmount: UILabel!
    
  //  @IBOutlet weak var totalTitle: UILabel!
  //  @IBOutlet weak var totalAmount: UILabel!
    
    let margin : CGFloat = 5.0
    
    var coupon: DiscountCoupon?
    var amount: Double!
    
    
    
    init(frame: CGRect, coupon: DiscountCoupon?, amount:Double) {
        super.init(frame: frame)
        self.coupon = coupon
        self.amount = amount
        if (self.coupon == nil){
            loadNoCouponView()
        }else{
            loadCouponView()
        }
        
        self.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.px_grayLight(), thickness: 1)
        /*
        let totalWidth = frame.size.width
        
        
        let tituloLabel = MPLabel(frame: CGRect(x: margin, y: margin, width: (frame.size.width - 2 * margin), height: 20) )
        tituloLabel.textAlignment = .center;
        tituloLabel.textAlignment = .center
        
        let contentViewSubSection = UIView(frame: CGRect(x: 0, y: (margin * 2 + 20), width: frame.size.width, height: 20))
        
        let detailLabel = MPLabel(frame: CGRect(x: margin, y: (margin * 2 + 20), width: (frame.size.width - 2 * margin), height: 20) )
        detailLabel.textAlignment = .center
        
        let rightArrow = UIImageView(frame: CGRect(x: 0, y: 4, width: 8, height: 12))
       rightArrow.image = MercadoPago.getImage("rightArrow")
        
        let couponFlag = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        couponFlag.image = MercadoPago.getImage("iconDiscount")
        
        let labelDiscount = MPLabel()
        labelDiscount.text = coupon?.getDiscountDescription()
        let widthlabelDiscount = labelDiscount.attributedText?.widthWithConstrainedHeight(height: 20)
        labelDiscount.backgroundColor = MercadoPagoContext.getPrimaryColor()
        
        self.addSubview(tituloLabel)

        if self.coupon == nil{
             tituloLabel.text = "No hay descuento"
            detailLabel.text = "Tengo un descuento".localized
        }
        
        
         let widthDetailLabel = detailLabel.attributedText?.widthWithConstrainedHeight(height: 20)
        detailLabel.frame = CGRect(x: margin, y: (margin * 2 + 20), width: widthDetailLabel!, height: 20)
        detailLabel.backgroundColor = .red
        self.addSubview(detailLabel)
        */
    }
    
    
    func loadNoCouponView() {
        let currency = MercadoPagoContext.getCurrency()
        let screenWidth = frame.size.width
        
        let tituloLabel = MPLabel(frame: CGRect(x: margin, y: 20, width: (frame.size.width - 2 * margin), height: 20) )
        tituloLabel.textAlignment = .center;
         let result = NSMutableAttributedString()
        
        let normalAttributes: [String:AnyObject] = [NSFontAttributeName : UIFont(name:MercadoPago.DEFAULT_FONT_NAME, size: 16) ?? UIFont.systemFont(ofSize: 16),NSForegroundColorAttributeName: UIColor.px_grayDark()]
        let total = NSMutableAttributedString(string: "Total: ".localized, attributes: normalAttributes)
        
        result.append(total)
        result.append(Utils.getAttributedAmount( amount, currency: currency, color : UIColor.px_grayDark(), fontSize: 16, baselineOffset:4))

        tituloLabel.attributedText = result
        
        
        let couponFlag = UIImageView()
        couponFlag.image = MercadoPago.getImage("iconDiscount")
        couponFlag.image = couponFlag.image?.withRenderingMode(.alwaysTemplate)
        couponFlag.tintColor = MercadoPagoContext.getPrimaryColor()
        
        let rightArrow = UIImageView()
        rightArrow.image = MercadoPago.getImage("rightArrow")
        rightArrow.image = rightArrow.image?.withRenderingMode(.alwaysTemplate)
        rightArrow.tintColor = MercadoPagoContext.getPrimaryColor()

        
        let detailLabel = MPLabel()
        detailLabel.textAlignment = .center
        detailLabel.text = "Tengo un descuento".localized
        detailLabel.textColor = MercadoPagoContext.getPrimaryColor()
        detailLabel.font = UIFont.init(name: detailLabel.font.fontName, size: 16)
        
        let widthlabelDiscount = detailLabel.attributedText?.widthWithConstrainedHeight(height: 18)
        let totalViewWidth = widthlabelDiscount! + 20 + 8 + 2 * margin
        var x = (screenWidth - totalViewWidth) / 2
        
        let frameFlag = CGRect(x: x, y: (margin * 2 + 40), width: 20, height: 20)
        couponFlag.frame = frameFlag
        x = x + 20 + margin
        let frameLabel = CGRect(x: x , y: (margin * 2 + 40), width: widthlabelDiscount!, height: 18)
        detailLabel.frame = frameLabel
         x = x + widthlabelDiscount! + margin
        let frameArrow = CGRect(x: x, y: 4 + (margin * 2 + 40), width: 8, height: 12)
        rightArrow.frame = frameArrow
        
        
        self.addSubview(tituloLabel)
        self.addSubview(couponFlag)
        self.addSubview(detailLabel)
        self.addSubview(rightArrow)
        
        
    }
    
    
    func loadCouponView() {
        let currency = MercadoPagoContext.getCurrency()
        let screenWidth = frame.size.width
        
        guard let coupon = self.coupon else {
            return
        }
        let tituloLabel = MPLabel(frame: CGRect(x: margin, y: 20, width: (frame.size.width - 2 * margin), height: 20) )
        tituloLabel.textAlignment = .center;
        let result = NSMutableAttributedString()
        
        let normalAttributes: [String:AnyObject] = [NSFontAttributeName : UIFont(name:MercadoPago.DEFAULT_FONT_NAME, size: 16) ?? UIFont.systemFont(ofSize: 16),NSForegroundColorAttributeName: UIColor.px_grayDark()]
        let total = NSMutableAttributedString(string: "Total: ".localized, attributes: normalAttributes)
        
        let space = NSMutableAttributedString(string: " ".localized, attributes: normalAttributes)
        
        
        let oldAmount = Utils.getAttributedAmount( amount, currency: currency, color : UIColor.px_grayDark(), fontSize: 16, baselineOffset:4)
        oldAmount.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, oldAmount.length))
        
        let newAmount = Utils.getAttributedAmount( coupon.newAmount(), currency: currency, color : UIColor.mpGreenishTeal(), fontSize: 16, baselineOffset:4)

        result.append(total)
        result.append(oldAmount)
        result.append(space)
        result.append(newAmount)
        tituloLabel.attributedText = result
        
        
        let picFlag = UIImageView()
        picFlag.image = MercadoPago.getImage("couponArrowFlag")
        picFlag.image = picFlag.image?.withRenderingMode(.alwaysTemplate)
        picFlag.tintColor = UIColor.mpGreenishTeal()
        
        
        let rightArrow = UIImageView()
        rightArrow.image = MercadoPago.getImage("rightArrow")

        
        
        let detailLabel = MPLabel()
        detailLabel.textAlignment = .center
        detailLabel.text = "Descuento".localized
        detailLabel.textColor = UIColor.mpGreenishTeal()
        detailLabel.font = UIFont.init(name: detailLabel.font.fontName, size: 16)
        
        let discountAmountLabel = MPLabel()
        discountAmountLabel.textAlignment = .center
        discountAmountLabel.text = coupon.getDiscountDescription()
        discountAmountLabel.backgroundColor = UIColor.mpGreenishTeal()
        discountAmountLabel.textColor = UIColor.white
        discountAmountLabel.font = UIFont.init(name: discountAmountLabel.font.fontName, size: 12)
        
        let widthlabelDiscount = detailLabel.attributedText?.widthWithConstrainedHeight(height: 18)
        let widthlabelAmount = (discountAmountLabel.attributedText?.widthWithConstrainedHeight(height: 12))! + 8
        let totalViewWidth = widthlabelDiscount! + widthlabelAmount + 10 + 8 + 2 * margin
        var x = (screenWidth - totalViewWidth) / 2
        
        
        let frameLabel = CGRect(x: x , y: (margin * 2 + 40), width: widthlabelDiscount!, height: 18)
        detailLabel.frame = frameLabel
        x = x + widthlabelDiscount! + margin
        
        let framePic = CGRect(x: x, y: (margin * 2 + 40), width: 10, height: 19)
        picFlag.frame = framePic
        x = x + 10
        
        let frameAmountLabel = CGRect(x: x , y: (margin * 2 + 40), width: widthlabelAmount, height: 19)
        discountAmountLabel.frame = frameAmountLabel
        x = x + widthlabelAmount + margin
        
        let frameArrow = CGRect(x: x, y: 4 + (margin * 2 + 40), width: 8, height: 12)
        rightArrow.frame = frameArrow
        
        
        self.addSubview(tituloLabel)
        self.addSubview(detailLabel)
        self.addSubview(picFlag)
        self.addSubview(discountAmountLabel)
        self.addSubview(rightArrow)
        
        
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
 //       loadViewFromNib ()
    }
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DiscountBodyCell", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
      
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }

}






extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}
