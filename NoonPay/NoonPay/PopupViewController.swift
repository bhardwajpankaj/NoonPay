//
//  PopupViewController.swift
//  NoonPay
//
//  Created by Pankaj Bhardwaj on 25/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import UIKit
protocol popupProtocol:NSObjectProtocol{
    func countrySlected(_ title:String)
}

class PopupViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityCodeButton1: UIButton!
    @IBOutlet weak var cityCodeButton2: UIButton!
    @IBOutlet weak var cityCodeButton3: UIButton!
    var viewModel = PopupViewModel()
    weak var delegate:popupProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cell: PopupTableViewCell.self)
    }
    // cross button action
    @IBAction func crossButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: false,completion:nil)
    }
    

}

// Tableview delegate and datasource methods
extension PopupViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cuntryCodeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PopupTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.setup(title: viewModel.countryNames[indexPath.row], flagImg:"flag\(indexPath.row)" , checkBoxSelected:viewModel.cuntryCodeArray[indexPath.row] == viewModel.selectedCountry ? true : false)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedCountry = viewModel.cuntryCodeArray[indexPath.row]
        self.delegate?.countrySlected(viewModel.cuntryCodeArray[indexPath.row])
        tableView.reloadData()
    }
    
    
}
