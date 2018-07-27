//
// Created by macmini_2 on 07/04/17.
// Copyright (c) 2017 010Minds. All rights reserved.
//

import UIKit

@objc public protocol SideMenuDelegate: class {
	var menu : SideMenuViewController! {get set}

	@objc optional func onMenuOpen()
	@objc optional func onMenuClose()
}
