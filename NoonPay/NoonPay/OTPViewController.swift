//
//  OTPViewController.swift
//  NoonPay
//
//  Created by Pankaj Bhardwaj on 25/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {
    
    @IBOutlet var otpBackTextField1:UITextField!
    @IBOutlet var otpBackTextField2:UITextField!
    @IBOutlet var otpBackTextField3:UITextField!
    @IBOutlet var otpBackTextField4:UITextField!
    
    
    @IBOutlet var otpBorder1:UIView!
    @IBOutlet var otpBorder2:UIView!
    @IBOutlet var otpBorder3:UIView!
    @IBOutlet var otpBorder4:UIView!
    
    @IBOutlet var otpTextField:OtpTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otpTextField.delegate = self
        otpTextField.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
        if #available(iOS 12.0, *) {
            otpTextField.textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        otpTextField.becomeFirstResponder()
    }
    class func instance()->OTPViewController{
        let oTPViewController = OTPViewController.init(nibName: "OTPViewController", bundle: nil)
        return oTPViewController
    }
    
    // Back button action
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // open code popup button action
    @IBAction func resendCodeButtonClicked(_ sender: Any) {
        
        Toast.showPositiveMessage(message: "code resent")

    }
    
    // Show Password button action
    @IBAction func submitCodeButtonClicked(_ sender: Any) {
        Toast.showPositiveMessage(message: "Code submit")

    }
    
    private func handleSubmitCodeButton()
    {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
    }
    
}
extension OTPViewController:UITextFieldDelegate{
    @objc func textFieldDidChange(_ textField:UITextField)
    {
        let str =  textField.text?.trim() ?? ""
        let arr = str.map { String($0) }
        if(arr.count == 1){
            otpBorder1.backgroundColor = AppColor.appYellowColor
        }else{
            otpBorder1.backgroundColor = AppColor.button.borderColor
        }
        
        if(arr.count == 2){
            otpBorder2.backgroundColor = AppColor.appYellowColor
        }else{
            otpBorder2.backgroundColor = AppColor.button.borderColor
        }
        if(arr.count == 3){
            otpBorder3.backgroundColor = AppColor.appYellowColor
        }else{
            otpBorder3.backgroundColor = AppColor.button.borderColor
        }
        if(arr.count == 4){
            otpBorder4.backgroundColor = AppColor.appYellowColor
        }else{
            otpBorder4.backgroundColor = AppColor.button.borderColor
        }
        
        otpBackTextField1.text = arr.count > 0 ? arr[0] : ""
        otpBackTextField2.text = arr.count > 1 ? arr[1] : ""
        otpBackTextField3.text = arr.count > 2 ? arr[2] : ""
        otpBackTextField4.text = arr.count > 3 ? arr[3] : ""
        handleSubmitCodeButton()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let textFieldText = textField.text ?? ""
        
        let currentString: NSString = textFieldText as NSString
        let maxLength = 4
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        if( newString.length > maxLength)
        {
            return false
        }
        
        return true
    }
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
