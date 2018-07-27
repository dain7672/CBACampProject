//
//  SideMenuHeaderFactory.swift
//  010SideMenu
//
//  Created by macmini_2 on 24/03/17.
//  Copyright © 2017 010Minds. All rights reserved.
//

import UIKit


public class SideMenuHeader: SideMenuBoxViewProtocol {

	func getView() -> UIView {
		fatalError("Subclasses need to implement the 'getView()' method.")
	}

}

public class SideMenuHeaderFactory {

	private var headerView: UIView!

	public static func make(title: String) -> SideMenuHeader {
		return SideMenuHeaderSimple(title: title)
	}

	public static func make(view: UIView) -> SideMenuHeader {
		return SideMenuHeaderView(view: view)
	}

	private class SideMenuHeaderSimple: SideMenuHeader {

		var title: String

		init(title: String) {
			self.title = title
		}

		public override func getView() -> UIView {
			let bundleController: Bundle = Bundle(for: SideMenuHeaderViewController.self)
			bundleController.loadNibNamed("SideMenuHeaderViewController", owner: SideMenuHeaderViewController(), options: nil)
			let sideMenuHeaderView: SideMenuHeaderViewController = SideMenuHeaderViewController(nibName: "SideMenuHeaderViewController", bundle: bundleController)
			sideMenuHeaderView.loadView()
			sideMenuHeaderView.setLabel(text: title)
			return sideMenuHeaderView.view
		}

	}

	private class SideMenuHeaderView: SideMenuHeader {

		var headerView: UIView
		init(view: UIView) {
			self.headerView = view
		}

		public override func getView() -> UIView {
			return self.headerView
		}

	}

}
