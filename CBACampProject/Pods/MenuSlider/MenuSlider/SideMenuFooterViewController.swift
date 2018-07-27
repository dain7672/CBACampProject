//
//  SideMenuFooterViewController.swift
//  010SideMenu
//
//  Created by macmini_2 on 03/04/17.
//  Copyright © 2017 010Minds. All rights reserved.
//

import UIKit

class SideMenuFooterViewController: UIViewController {

	@IBOutlet var footerView: UIView!
	@IBOutlet weak var label: UILabel!

	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setLabel(text: String) {
		self.label.text = text
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
	}

}
