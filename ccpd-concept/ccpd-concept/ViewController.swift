//
//  ViewController.swift
//  ccpd-concept
//
//  Created by Henrique Dourado on 06/03/16.
//  Copyright © 2016 Henrique Dourado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appNameLbl: UILabel!
    @IBOutlet weak var theView: UIImageView!
    @IBOutlet weak var instagramIcon: UIButton!
    @IBOutlet weak var instagramFloatingIcon: UIImageView!
    @IBOutlet weak var instagramView: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    
    var touches = 0
    
    var original = CGPoint(x: 100, y: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       original = instagramIcon.center
        
        closeBtn.hidden = true
        closeBtn.alpha = 0.0
        
        instagramView.alpha = 0.0
        instagramView.center = CGPoint(x: 187.5, y: 390.0)
        instagramView.layer.cornerRadius = 6.0
        instagramView.clipsToBounds = true
        
        instagramFloatingIcon.alpha = 0.0
        instagramFloatingIcon.center = CGPoint(x: 187.5, y: 70.0)
        
        appNameLbl.alpha = 0.0
        appNameLbl.center = CGPoint(x: 187.5, y: 105.0)
        
        appNameLbl.text = "Instagram"
    }
    
    @IBAction func closeBtnPressed(sender: AnyObject) {
        if let blurView = self.view.viewWithTag(3) {
            
            let alert = UIAlertController(title: "Are you sure?", message: "Do you really want to leave quick launch mode?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { action in
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    blurView.removeFromSuperview()
                    self.changeAlpha(0.0)
                    self.instagramIcon.hidden = false
                    self.instagramIcon.alpha = 1.0
                    self.instagramIcon.center = self.original
                })
                
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func instagramIconPressed(sender: AnyObject) {
        touches++
        
        if touches == 2 && self.view.viewWithTag(3) == nil {
            
            let effect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurView = UIVisualEffectView(effect: effect)
            blurView.frame = self.view.bounds
            blurView.tag = 3
            
            self.view.insertSubview(blurView, aboveSubview: theView)
            self.closeBtn.hidden = false
            
            UIView.animateWithDuration(0.7, animations: {
                
                self.instagramIcon.center = CGPoint(x: 187.5, y: 70.0)
                self.instagramIcon.alpha = 0.0
                
                }, completion: { finished in
                    
                    self.instagramIcon.hidden = true
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.changeAlpha(1.0)
                    })
            })
            
            
            
            self.touches = 0
            
        }
    }
    
    func changeAlpha(alpha: CGFloat) {
        self.instagramFloatingIcon.alpha = alpha
        self.appNameLbl.alpha = alpha
        self.instagramView.alpha = alpha
        self.closeBtn.alpha = alpha
    }
}

