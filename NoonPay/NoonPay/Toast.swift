//
//  Toast.swift
//  David
//
//  Created by macpro on 25/02/19.
//  Copyright © 2019 MacTest. All rights reserved.
//

import Foundation
import UIKit

class Toast {
    
    class private func showAlert(backgroundColor:UIColor, textColor:UIColor, message:String,image:String?,duration:TTGSnackbarDuration = .middle, font:UIFont,containerView:UIView? = nil)
    {
        
        let snackbar: TTGSnackbar = TTGSnackbar.init(message: message, duration: duration)
        snackbar.contentInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 16)
        
        // Change message text font and color
        snackbar.messageTextColor = textColor
        snackbar.messageTextFont =  font
        if let image = UIImage(named: image ?? ""){
            snackbar.icon = image
        }
        // Change snackbar background color
        snackbar.backgroundColor = backgroundColor
        snackbar.containerView = containerView
        // Change animation duration
        snackbar.animationDuration = 0.5
        
        // Animation type
        snackbar.animationType = .slideFromBottomBackToBottom
        snackbar.show()
    }
    
    class func showPositiveMessage(message:String,image:String? = nil,duration:TTGSnackbarDuration = .middle, font:UIFont  = UIFont.systemFont(ofSize: 14),containerView:UIView? = nil)
    {
        showAlert(backgroundColor: AppColor.appGreenColorWithAlpha, textColor: AppColor.appGreenColor, message: message, image: image,duration: duration, font: font,containerView: containerView)
    }
    class func showNegativeMessage(message:String,image:String? = nil, font:UIFont  =  UIFont.systemFont(ofSize: 14),containerView:UIView? = nil)
    {
        if message.trim().count == 0 {
            return
        }
        showAlert(backgroundColor: UIColor(red: 230/255, green: 77/255, blue: 99/255, alpha: 1.0), textColor: UIColor.white, message: message, image: image, font: font,containerView: containerView)
    }
    
    class func showNeutralMessage(message:String,image:String? = nil, font:UIFont =  UIFont.systemFont(ofSize: 14),containerView:UIView? = nil)
    {
        showAlert(backgroundColor: UIColor(red: 238/255, green: 246/255, blue: 255/255, alpha: 1.0), textColor: UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1.0), message: message, image: image, font: font,containerView: containerView)
    }
}
