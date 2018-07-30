//
//  SideMenuItemViewController.swift
//  010SideMenu
//
//  Created by macmini_2 on 29/03/17.
//  Copyright © 2017 010Minds. All rights reserved.
//

import UIKit

public class SideMenuItemViewController: UIViewController {

	@IBOutlet weak var labelText: UILabel!

	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public func setLabel(text: String) {
		self.labelText?.text? = text
	}

}
