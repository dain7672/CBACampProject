//
//  ScheduleTapViewController.swift
//  CBACampProject
//
//  Created by mac on 2018. 7. 24..
//  Copyright © 2018년 mac. All rights reserved.
//

import UIKit

class ScheduleTabViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var Hamberger: UIButton!
    @IBAction func HambergerAction(_ sender: Any) {
        Hamberger.popIn(fromScale: 1.5, duration: 2, delay: 0)
    }
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    var image : UIImage?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "SegueToSideMenu"{
            if let navController = segue.destination as? UINavigationController{
                if let SideMenuController = navController.topViewController as?
                    SideBarViewController {
                    print("aaaa")
                    SideMenuController.Check = true
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = UIImage(named: "timetable.png")!
        //check whether there is updated image.
        FirebaseModel().downloadImage(name: "iOS_timetable.png", imageView: imageView)
        
        scrollView.contentSize = (imageView.frame.size)
        
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ScheduleTabViewController.scrollViewDoubleTapped(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        scrollView.minimumZoomScale = minScale

        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale
        
        centerScrollViewContents()
        // Do any additional setup after loading the view.
        
    }
    
    func centerScrollViewContents(){
        let boundsSize = scrollView.bounds.size
        var contensFrame = imageView.frame
        
        if contensFrame.size.width < boundsSize.width{
            contensFrame.origin.x = (boundsSize.width - contensFrame.size.width) / 2.0
        } else{
            contensFrame.origin.x = 0.0
        }
        if contensFrame.size.height < boundsSize.height {
            contensFrame.origin.y = (boundsSize.height - contensFrame.size.height) / 2.0
        } else{
            contensFrame.origin.y = 0.0
        }
        imageView.frame = contensFrame
    }
    
    @objc func scrollViewDoubleTapped(_ recognizer: UITapGestureRecognizer){
        let pointInView = recognizer.location(in: imageView)
        
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w/2.0)
        let y = pointInView.y - (h/2.0)
        
        let rectToZoomTo = CGRect(x: x, y:y, width: w, height: h)
        
        scrollView.zoom(to: rectToZoomTo, animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
