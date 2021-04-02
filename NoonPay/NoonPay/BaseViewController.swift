//
//  BaseViewController.swift
//  NoonPay
//
//  Created by Pankaj Bhardwaj on 25/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

   func showBlurLoader(){
    self.view.isUserInteractionEnabled = false
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT))
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            let activityIndicator = UIActivityIndicatorView(style:.large)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.color = UIColor.black
          
            let enclosingView = LoaderView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            enclosingView.backgroundColor = .white
            enclosingView.addSubview(activityIndicator)
            
            blurEffectView.contentView.addSubview(enclosingView)
            enclosingView.center = blurEffectView.center
            
            self.view.addSubview(blurEffectView)
            blurEffectView.translatesAutoresizingMaskIntoConstraints = false
            blurEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            blurEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            blurEffectView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            blurEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

            activityIndicator.startAnimating()
        }
        
        func removeBlurLoader(){
            self.view.isUserInteractionEnabled = true

            self.view.subviews.compactMap {  $0 as? UIVisualEffectView }.forEach {
                $0.removeFromSuperview()
            }
        }
    
}

public final class LoaderView:UIView{
    
}
