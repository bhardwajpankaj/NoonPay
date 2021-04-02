//
//  Constants.swift
//  DropDown
//
//  Created by Kevin Hirsch on 28/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

import UIKit

internal struct DPDConstant {

	internal struct KeyPath {

		static let Frame = "frame"

	}

	internal struct ReusableIdentifier {

		static let DropDownCell = "DropDownCell"

	}

	internal struct UI {

		static let TextColor = UIColor(red: 4/255, green: 10/255, blue: 30/255, alpha: 1.0)
        static let SelectedTextColor = UIColor.black
		static let TextFont = UIFont.systemFont(ofSize: 15)
		static let BackgroundColor = UIColor.white
		static let SelectionBackgroundColor = UIColor(white: 0.89, alpha: 1)
		static let SeparatorColor = UIColor.clear
		static let CornerRadius: CGFloat = 4.0
		static let RowHeight: CGFloat = 44
		static let HeightPadding: CGFloat = 20

		struct Shadow {

			static let Color = UIColor(red: 15/255, green: 54/255, blue: 136/255, alpha: 1.0)
			static let Offset = CGSize(width: 0, height: 3)
			static let Opacity: Float = 0.1
			static let Radius: CGFloat = 7.5

		}

	}

	internal struct Animation {

		static let Duration = 0.15
		static let EntranceOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseOut]
		static let ExitOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseIn]
		static let DownScaleTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)

	}

}
