//
//  LoginViewController.swift
//  NoonPay
//
//  Created by Pankaj Bhardwaj on 24/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var mobileNoTextField: UITextField!
    @IBOutlet weak var passworTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var countryCodeButton: UIButton!
    
    var viewModel = LoginVCViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    private func setupUI()
    {
        signInButton.isEnabled = false
        signInButton.alpha = 0.5
        mobileNoTextField.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
        passworTextField.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
        countryCodeButton.setTitle(viewModel.cuntryCodeArray.first, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    @objc func textFieldDidChange(_ textField:UITextField)
    {
        handleSignInButton()
    }
    
    // open code popup button action
    @IBAction func codeButtonClicked(_ sender: Any) {
        let vc = PopupViewController()
        vc.delegate = self
        vc.viewModel.selectedCountry = viewModel.cuntryCodeArray.first ?? "+971"
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    // Show Password button action
    @IBAction func showPasswordButtonClicked(_ sender: Any) {
        if passworTextField.isSecureTextEntry{
            passworTextField.isSecureTextEntry = false
        }else{
            passworTextField.isSecureTextEntry = true
        }
    }
    
    // Forget Password action
    @IBAction func forgetPasswordButtonClicked(_ sender: Any) {
    }
    
    // Sign In button action
    @IBAction func signInButtonClicked(_ sender: Any) {
        
        self.showBlurLoader()
        viewModel.loginPost(phoneNo: self.mobileNoTextField.text?.trim() ?? "", password: self.passworTextField.text?.trim() ?? "", completionHandler: {[weak self](isSuccess) in
            if(isSuccess ?? false){
                DispatchQueue.main.async {
                    self?.authenticateUser()
                    self?.removeBlurLoader()
                }
            }else
            {
                DispatchQueue.main.async {
                    //Handle error
                    self?.removeBlurLoader()
                }
            }
        })
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        let ac = UIAlertController(title: "Logged In Successfuly", message: "Home Page coming soon.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                        
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                        let vc = SignupViewController.instance()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    // Sign Up button action
    @IBAction func signUpButtonClicked(_ sender: Any) {
        let vc = SignupViewController.instance()
        self.navigationController?.pushViewController(vc, animated: true)        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func handleSignInButton(){
        if(mobileNoTextField.text?.trim().count ?? 0 > 0 && passworTextField.text?.trim().count ?? 0 > 0){
            signInButton.isEnabled = true
            signInButton.alpha = 1
        }else
        {
            signInButton.isEnabled = false
            signInButton.alpha = 0.5
        }
    }
}

extension LoginViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == mobileNoTextField {
            viewModel.type = .Mobile
        }else if textField == passworTextField {
            viewModel.type = .Password
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let textFieldText = textField.text ?? ""
        
        let currentString: NSString = textFieldText as NSString
        
        switch viewModel.type {
        case .Mobile?:
            let maxLength = 9
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            if( newString.length > maxLength)
            {
                return false
            }
            let validString = CharacterSet(charactersIn: "+0123456789").inverted
            
            if let range = string.rangeOfCharacter(from: validString)
            {
                print(range)
                return false
            }
        default:
            let maxLength = 50
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            if( newString.length > maxLength)
            {
                return false
            }
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

extension LoginViewController:popupProtocol{
    func countrySlected(_ title:String) {
        countryCodeButton.setTitle(title, for: .normal)
    }
}
