//
//  mapaViewController.swift
//  MobicongressIOS
//
//  Created by Arturo Sanhueza on 12-03-15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class mapaViewController: UIViewController, UIScrollViewDelegate{

    var mapaInfo:Place!
    var mutuMapas = NSMutableArray()
    var puntoX:NSNumber!
    var puntoY:NSNumber!
    var planoImagen:UIImage!
    var scrollView:UIScrollView!
    var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.layer.frame.width, self.view.layer.frame.height - 64))
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor .blackColor()
        view.backgroundColor = UIColor .blackColor()
        
        println(planoImagen)
        
        imageView = UIImageView(image: planoImagen)
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:planoImagen.size)
        scrollView.addSubview(imageView)
        var pin = UIImageView(image: UIImage(named: "pin"))
        pin.frame = CGRectMake(imageView.layer.frame.width * CGFloat(puntoX), imageView.layer.frame.height * CGFloat(puntoY), 60  , 60)
        
        // 2
        scrollView.contentSize = planoImagen.size
        
        // 3
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        // 4
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        scrollView.minimumZoomScale = minScale;
        
        // 5
        scrollView.maximumZoomScale = 2.0
        scrollView.zoomScale = minScale;
        
        // 6
        
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50
            , right: 0)
        centerScrollViewContents()
        
        imageView.addSubview(pin)
        view.addSubview(scrollView)
        
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        imageView.frame = contentsFrame
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // 1
        let pointInView = recognizer.locationInView(imageView)
        
        // 2
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        // 3
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        // 4
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
         tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
    }
    
}
