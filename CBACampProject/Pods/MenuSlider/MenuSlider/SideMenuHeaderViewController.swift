//
//  SideMenuHeaderViewController.swift
//  010SideMenu
//
//  Created by macmini_2 on 31/03/17.
//  Copyright © 2017 010Minds. All rights reserved.
//

import UIKit

class SideMenuHeaderViewController: UIViewController {

    var image : UIImage?
	@IBOutlet var headerView: UIView!
	@IBOutlet weak var label: UILabel!
    @IBOutlet weak var Image: UIImageView!
    
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
        self.image = UIImage(named: "Berea1.png")
        self.Image.image = self.image
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
