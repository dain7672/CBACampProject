//
//  SideMenuHeaderViewController.swift
//  010SideMenu
//
//  Created by macmini_2 on 31/03/17.
//  Copyright © 2017 010Minds. All rights reserved.
//

import UIKit

class SideMenuHeaderViewController: UIViewController {

	@IBOutlet var headerView: UIView!
	@IBOutlet weak var label: UILabel!

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	func setLabel(text: String) {
		self.label.text = text
        self.label.font = UIFont(name: "NotoSans-Bold", size: 18.0)!
        self.label.sizeToFit()
        self.label.frame.origin.x = self.headerView.frame.size.width / 2 - self.label.frame.size.width / 2
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
