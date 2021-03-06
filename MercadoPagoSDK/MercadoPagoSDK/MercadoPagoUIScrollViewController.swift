//
//  MercadoPagoUIScrollViewController.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 11/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

open class MercadoPagoUIScrollViewController: MercadoPagoUIViewController {

    var displayNavBar = false
    var lastContentOffset: CGFloat = 0
    var scrollingDown = false
    let navBarHeigth: CGFloat = 44
    let statusBarHeigth: CGFloat = 20
    var titleCellHeight: CGFloat = 70
    var titleCell: TitleCellScrollable?
    
    func scrollPositionToShowNavBar () -> CGFloat {
        return titleCellHeight - statusBarHeigth
    }
    
    func didScrollInTable(_ scrollView: UIScrollView) {
        navBarFontSize = 18
        if let titleCell = titleCell {
            let fontSize = 18 - (scrollView.contentOffset.y + scrollPositionToShowNavBar())/(CGFloat(64) - scrollPositionToShowNavBar())*4
            
            if fontSize<24 {
                titleCell.updateTitleFontSize(toSize: fontSize)
            } else {
                titleCell.updateTitleFontSize(toSize: 24)
            }
            
        }

        if (scrollView.contentOffset.y > -scrollPositionToShowNavBar() ) {
            showNavBar()
        } else {
            hideNavBar()
        }
    }
    
    
    override func getNavigationBarTitle() -> String {
        return ""
    }
  
}
protocol TitleCellScrollable{
    func updateTitleFontSize(toSize: CGFloat);
    
}
