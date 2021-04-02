//
//  PopupTableViewCell.swift
//  NoonPay
//
//  Created by Pankaj Bhardwaj on 25/08/20.
//  Copyright © 2020 pankaj. All rights reserved.
//

import UIKit

class PopupTableViewCell: UITableViewCell,NibLoadableView,ReuseIdentifier {

    @IBOutlet weak var flagImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var checkBox: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(title:String,flagImg:String,checkBoxSelected:Bool)
    {
        flagImgView.image = UIImage(named: flagImg)
        titleLbl.text = title
        if(checkBoxSelected == true){
            checkBox.image = UIImage(named: "checkbox_selected")
        }else{
            checkBox.image = UIImage(named: "checkbox_unselected")
        }
    }
    
}
