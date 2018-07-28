//
//  MassageTapViewController.swift
//  CBACampProject
//
//  Created by mac on 2018. 7. 24..
//  Copyright © 2018년 mac. All rights reserved.
//

import UIKit

class MassageTabViewController: UIViewController {
    @IBOutlet weak var Hamberger: UIButton!
    @IBAction func HambergerAction(_ sender: Any) {
        Hamberger.popIn(fromScale: 1.5, duration: 2, delay: 0)
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    var url = URL(string:"http://cbapray.sungrak.or.kr/RetreatSite/RetreatAdd")
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "SegueToSideMenu"{
            if let navController = segue.destination as? UINavigationController{
                if let SideMenuController = navController.topViewController as?
                    SideBarViewController {
                    SideMenuController.Check = true
                }
            }
        }
    }
    
    @IBOutlet weak var ApplicationOutlet: UIButton!
    @IBAction func ApplicationAction(_ sender: Any) {
        ApplicationOutlet.popIn(fromScale: 20, duration: 4, delay: 0)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = self.view.frame.height / 2
        let width = self.view.frame.width / 2
        super.viewDidLoad()
        scrollView.frame.size.width = scrollView.frame.size.width + 20
        let scrollcontainerView = UIView(frame: scrollView.frame)
        scrollView.addSubview(scrollcontainerView)
        
        var inypos = 10
        let inxpos = 20
        for i in 0...9 {
            let cellview = UIView()
            cellview.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0).cgColor
            cellview.layer.borderWidth = 1
            cellview.backgroundColor = UIColor.white
            
            //높이: 기본값으로 둘 수 있을 것이다. 나중에 max등으로 비교해서 적용하도록.
            cellview.frame = CGRect(x: 10, y: i * 90 + 10, width : Int(scrollView.frame.width), height: 80)
            scrollView.addSubview(cellview)
            
            //profile image, rank name label, name label //////////////////////////////
            let profileimgview = UIImageView()
            profileimgview.frame = CGRect(x:10, y:10, width: 40, height: 40)
            profileimgview.contentMode = UIViewContentMode.scaleAspectFill
            profileimgview.clipsToBounds = true //image set 전에 해주어야 한다.
            profileimgview.image = UIImage(named: "profile.png")
            profileimgview.layer.cornerRadius = profileimgview.frame.width / 2
            cellview.addSubview(profileimgview)
            
            //textview///////////////////////////////////////
            let textview = UITextView()
            textview.text = "첫 글입니다 ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ"
            textview.font = UIFont(name: "NotoSans", size: 16.0)!
            textview.frame.origin = CGPoint(x:inxpos + 35, y:10)
            textview.frame.size = CGSize(width: Int(scrollView.frame.width) - inxpos * 2 - 45, height: 30)
            let contentSize = textview.sizeThatFits(textview.bounds.size)
            var frame = textview.frame
            frame.size.height = max(contentSize.height, 30)
            textview.frame = frame
            let aspectRatioTextViewConstraint = NSLayoutConstraint(item: textview, attribute: .height, relatedBy: .equal, toItem: textview, attribute: .width, multiplier: textview.bounds.height/textview.bounds.width, constant: 1)
            textview.addConstraint(aspectRatioTextViewConstraint)
            textview.isScrollEnabled = false
            textview.isEditable = false
            textview.isUserInteractionEnabled = true
            textview.backgroundColor = UIColor.lightGray
            cellview.addSubview(textview)
            
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 1000)
        scrollView.isScrollEnabled = true
        self.view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

