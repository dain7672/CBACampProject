//
//  SideMenu.swift
//  010SideMenu
//
//  Created by macmini_2 on 28/03/17.
//  Copyright © 2017 010Minds. All rights reserved.
//

import Foundation
import UIKit

public class SideMenu {

	var menuViewController: SideMenuViewController?
	var menuItems: [SideMenuItem]
	var headerView: SideMenuHeader?
	var footerView: SideMenuFooter?

	public init(menuItems items: [SideMenuItem]) {
		self.menuItems = items
	}

	public init(menuItems items: [SideMenuItem], header headerView: SideMenuHeader) {
		self.menuItems = items
		self.headerView = headerView
	}

	public init(menuItems items: [SideMenuItem], footer footerView: SideMenuFooter) {
		self.menuItems = items
		self.footerView = footerView
	}

	public init(menuItems items: [SideMenuItem], header headerView: SideMenuHeader, footer footerView: SideMenuFooter) {
		self.menuItems = items
		self.headerView = headerView
		self.footerView = footerView
	}

	public func build() -> SideMenuViewController! {
		
		let bundleController: Bundle = Bundle(for: SideMenuViewController.self)
		bundleController.loadNibNamed("SideMenuViewController", owner: SideMenuViewController(), options: nil)
		self.menuViewController = SideMenuViewController(nibName: "SideMenuViewController", bundle: bundleController)
		self.menuViewController?.loadView()

		self.menuViewController?.setItems(items: menuItems)

		if (self.headerView) != nil {
			self.menuViewController?.setHeader(view: self.headerView!)
		}
		
		if (self.footerView) != nil {
			self.menuViewController?.setFooter(view: self.footerView!)
		}

		self.menuViewController?.viewDidLoad()

		return self.menuViewController
	}

}
