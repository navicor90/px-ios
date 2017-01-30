//
//  LoadingOverlay.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 12/15/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

open class LoadingOverlay {

    var container = UIView()
    var activityIndicator = UIActivityIndicatorView()
    //var loadingContainer : MPSDKLoadingView!
    var screenContainer = UIView()

    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

    init() {

    }

    open func getDefaultLoadingOverlay(_ view: UIView, backgroundColor: UIColor, indicatorColor: UIColor) -> UIView {
      return UIView()
    }

    open func showOverlay(_ view: UIView, backgroundColor: UIColor, indicatorColor: UIColor = UIColor.px_white()) -> UIView {
        return UIView()
    }

    open func hideOverlayView() {

    }

}
