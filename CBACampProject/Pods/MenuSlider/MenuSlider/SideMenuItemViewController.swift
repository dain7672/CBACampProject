//
//  SideMenuItemViewController.swift
//  010SideMenu
//
//  Created by macmini_2 on 29/03/17.
//  Copyright © 2017 010Minds. All rights reserved.
//

import UIKit

public class SideMenuItemViewController: UIViewController {

    var image : UIImage?
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var labelText: UILabel!

	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    func setLabel(text: String) {
        self.image = UIImage(named: "CampBackground.jpeg")
        self.Image.alpha = 0.1
        self.Image.image = self.image
        
        self.labelText?.text? = text
    }

}
