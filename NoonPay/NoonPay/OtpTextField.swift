//
//  OtpTextField.swift
//  NoonPay
//
//  Created by Pankaj Bhardwaj on 25/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import Foundation
import UIKit

class OtpTextField: UITextField {
    override func caretRect(for position: UITextPosition) -> CGRect {
    return CGRect.zero
    }
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    
    if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {
    
    return false
    }
    
    return super.canPerformAction(action, withSender: sender)
    }
    override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.isKind(of: UILongPressGestureRecognizer.self) {
            gestureRecognizer.isEnabled = false
        }
        return super.addGestureRecognizer(gestureRecognizer)
    }
}
