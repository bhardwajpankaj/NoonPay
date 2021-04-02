//
//  SignupViewController.swift
//  NoonPay
//
//  Created by Pankaj Bhardwaj on 24/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import UIKit

enum FieldType:String {
    case Email
    case Mobile
    case Password
    case None
}

class SignupViewController: UIViewController {
    
    @IBOutlet weak var mobileNoTextField: UITextField!
    @IBOutlet weak var passworTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityCodeButton: UIButton!
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var tncButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    let dropDown = DropDown()
    let viewModel = SignupViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropDown()
        setupUI()
    }
    
    @objc func textFieldDidChange(_ textField:UITextField)
    {
        handleContinueButton()
        
    }
    
    class func instance()->SignupViewController{
        let signupViewController = SignupViewController.init(nibName: "SignupViewController", bundle: nil)
        return signupViewController
    }
    
    private func setupUI()
    {
        countryCodeButton.setTitle(viewModel.cuntryCodeArray.first, for: .normal)
        cityCodeButton.setTitle(viewModel.cityArray.first, for: .normal)
        
        self.continueButton.isEnabled = false
        self.continueButton.alpha = 0.5
        mobileNoTextField.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
        passworTextField.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func showDropDownWith(_ array:[String], _ anchorView:UIView)
    {
        self.dropDown.dataSource = array
        self.dropDown.reloadAllComponents()
        self.dropDown.anchorView = anchorView // UIView or UIBarButtonItem
        self.dropDown.xPosition = nil
        self.dropDown.width = 60
        self.dropDown.show()
    }
    
    private func setupDropDown()
    {
        dropDown.direction = .any
        dropDown.bottomOffset = CGPoint(x: 0, y:35)
        dropDown.topOffset = CGPoint(x: 0, y:-( 30))
        dropDown.backgroundColor = .white
        dropDown.hide()
        
        // Action triggered on selection
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self?.cityCodeButton.setTitle("\(item)", for: .normal)
        }
    }
    
    // Back button action
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // open code popup button action
    @IBAction func codeButtonClicked(_ sender: Any) {
        let popupVC = PopupViewController()
        popupVC.delegate = self
        popupVC.viewModel.selectedCountry = viewModel.cuntryCodeArray.first ?? "+971"
        popupVC.modalPresentationStyle = .overFullScreen
        self.present(popupVC, animated: true, completion: nil)
    }
    
    // Show Password button action
    @IBAction func showPasswordButtonClicked(_ sender: Any) {
        if passworTextField.isSecureTextEntry{
            passworTextField.isSecureTextEntry = false
        }else{
            passworTextField.isSecureTextEntry = true
        }
    }
    
    // city action
    @IBAction func cityButtonClicked(_ sender: UIButton) {
        showDropDownWith(viewModel.cityArray, sender)
    }
    
    // checbox tnc action
    @IBAction func tncButtonClicked(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            sender.setImage(UIImage(named: "checkbox_unselected"), for: .selected)
        }else{
            sender.isSelected = true
            sender.setImage(UIImage(named: "checkbox_selected"), for: .selected)
        }
        handleContinueButton()
    }
    
    // Sign In button action
    @IBAction func signInButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Sign Up button action
    @IBAction func continueButtonClicked(_ sender: Any) {
        Toast.showPositiveMessage(message: "Signup Success")
        let vc = OTPViewController.instance()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // Handle continue button state
    private func handleContinueButton()
    {
        if(self.mobileNoTextField.text?.count ?? 0 > 0 && self.passworTextField.text?.count ?? 0 > 0 && tncButton.isSelected){
            self.continueButton.isEnabled = true
            self.continueButton.alpha = 1
        }else{
            self.continueButton.isEnabled = false
            self.continueButton.alpha = 0.5
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SignupViewController:popupProtocol{
    func countrySlected(_ title:String) {
        countryCodeButton.setTitle(title, for: .normal)
    }
}

extension SignupViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == mobileNoTextField {
            viewModel.type = .Mobile
        }else if textField == passworTextField {
            viewModel.type = .Password
        }else if textField == emailTextField {
            viewModel.type = .Email
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let textFieldText = textField.text ?? ""
        
        let currentString: NSString = textFieldText as NSString
        
        switch viewModel.type {
        case .Mobile?:
            let maxLength = 7
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if viewModel.type == .Email{
            if self.isValid(type: .Email, testStr: textField.text ?? ""){
                print("")
            }else
            {
                print("Incorrect email format!")
            }
        }
    }
    
    func isValid(type:FieldType, testStr:String) -> Bool {
        var regEx = ""
        switch type {
        case .Email:
            regEx = "(?!\\.)(?!.*\\.$)(?!.*?\\.\\.)[A-Z0-9a-z._-]+\\@[A-Za-z0-9-.]+\\.[A-Za-z]{2,64}"
        case .None,.Mobile,.Password:
            regEx = ""
        }
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
