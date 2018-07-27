//
//  SideMenuViewController.swift
//  010SideMenu
//
//  Created by macmini_2 on 24/03/17.
//  Copyright © 2017 010Minds. All rights reserved.
//

import UIKit

public class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public weak var delegate: SideMenuDelegate! {
		didSet {
			self.didSetDelegate()
		}
	}

    let cellReuseIdentifier = "cell"
    var items: [SideMenuItem] = []
	var menuItems: [SideMenuItem] = []
    var count: Int = 0
    var customHeaderView: SideMenuHeader?
    var customHeader: UIView!
    var customFooterView: SideMenuFooter?
    var customFooter: UIView!
    var boxViewCenterX: CGFloat!

    @IBOutlet weak var header: UIView!

    @IBOutlet weak var footer: UIView!

    @IBOutlet weak var table: UITableView!

	@IBOutlet weak var menu: UIView!

    @IBAction func swipeLeft(_ sender: Any) {
        self.reduceMenu()
    }

	public func expand(onController controller: UIViewController) {
		controller.present(self, animated: false, completion: {
			self.expandMenu()
			self.delegate.onMenuOpen?()
		})
	}

    public func setHeader(view: SideMenuHeader) {
        view.getView().autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.customHeaderView = view
    }

    public func setFooter(view: SideMenuFooter) {
        view.getView().autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.customFooterView = view
    }

    public func getHeaderView() -> UIView {
        if let cv = self.customHeaderView {
            return cv.getView()
        }
        return SideMenuHeaderViewController().view
    }

    public func getFooterView() -> UIView {
        if let cv = self.customFooterView {
            return cv.getView()
        }

        return SideMenuFooterViewController().view
    }

	public func setItems(items: [SideMenuItem]) {
		self.items = items
	}

	public func expandMenu() {
		self.animateCenterPanelXPosition(targetPosition: 0)
	}

	public func reduceMenu() {
		self.animateCenterPanelXPosition(targetPosition: -self.menu.frame.width - 2)
	}

	override public func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

    override public func viewDidLoad() {
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.fieldTapped(recognizer:)))
        self.menu.addGestureRecognizer(panGestureRecognizer)

		self.setMenuShadow()

        self.customFooter = getFooterView()
        self.customHeader = getHeaderView()
        self.customHeader.frame = self.header.frame
        self.customFooter.frame = self.footer.frame
        self.customFooter.frame.origin.x = 0
        self.customFooter.frame.origin.y = 0

        self.footer.addSubview(self.customFooter)
        self.header.addSubview(self.customHeader)

        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none

        self.boxViewCenterX = menu.center.x
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self.customFooter && touch?.view != self.footer && touch?.view != self.customHeader {
            self.reduceMenu()
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuItemsCount = self.items.count
        if menuItemsCount > 0 {
            self.count = menuItemsCount
            return menuItemsCount
		}
        self.count = menuItems.count
        return menuItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        let item: SideMenuItem = self.items[indexPath.row]
        let view = item.getView()
        view.frame = cell.frame
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.addSubview(view)

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.reduceMenu()
        self.items[indexPath.row].action()
    }

    @objc func fieldTapped(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed:
			if canDragMenu(recognizer) {
				dragMenu(recognizer)
			}
        case .ended:
			self.toggleMenu(recognizer)
        default:
            break
        }
    }

    private func setMenuShadow(opacity: Float = 0.9, radius: CGFloat = 5) {
        let layer = self.menu.layer
        layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }

	private func didSetDelegate() {
		self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.alpha = 1
		self.modalPresentationStyle = .overCurrentContext
	}

    private func animateCenterPanelXPosition(targetPosition: CGFloat, duration: CGFloat = 0.3) {
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
            self.menu.frame.origin.x = targetPosition
        }, completion: { (finished: Bool) in
            if targetPosition == -(self.menu.frame.width) - 2 {
				self.dismiss(animated: false, completion: {
					self.delegate.onMenuClose?()
				})
            }
        })
    }

    private func toggleMenu(_ recognizer: UIPanGestureRecognizer) -> Void {
		if recognizer.view!.center.x <= 40 {
			self.reduceMenu()
			return
		}
		self.expandMenu()
	}

	private func canDragMenu(_ recognizer: UIPanGestureRecognizer) -> Bool {
		let gestureIsDraggingFromLeftToRight = recognizer.velocity(in: view).x > 0
		let isMenuOriginPositionOut = self.menu.frame.origin.x >= 0
		let recognizerCenterX = recognizer.view!.center.x

		if isMenuOriginPositionOut && gestureIsDraggingFromLeftToRight {
			return false
		}

		if isMenuOriginPositionOut && recognizer.translation(in: view).x > 0 {
			return false
		}

		if recognizerCenterX + recognizer.translation(in: view).x > self.boxViewCenterX * -1 {
			animateCenterPanelXPosition(targetPosition: 0, duration: 0)
			return false
		}

		return true
	}

	private func dragMenu(_ recognizer: UIPanGestureRecognizer) -> Void {
		let recognizerCenterX = recognizer.view!.center.x
		recognizer.view!.center.x = recognizerCenterX + recognizer.translation(in: view).x
		recognizer.setTranslation(CGPoint.zero, in: view)
	}

}
