//
//  MailboxViewController.swift
//  Assignment 3: Mailbox
//
//  Created by Jeremy Friedland on 6/4/16.
//  Copyright © 2016 Jeremy Friedland. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
   
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageViewContainer: UIView!
    @IBOutlet weak var archiveView: UIImageView!
    @IBOutlet weak var laterView: UIImageView!
    
    // Message Position Variables
    var messageOriginalCenter: CGPoint!
    var messageRight: CGPoint!
    var messageLeft: CGPoint!
    var messageOffset: CGFloat!
    
    // Color Variables
    var backgroundRed = UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    var backgroundGreen = UIColor(red: 25/255.0, green: 156/255.0, blue: 54/255.0, alpha: 1.0)
    var backgroundGrey = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1.0)
    var backgroundYellow = UIColor(red: 248/255.0, green: 203/255.0, blue: 39/255.0, alpha: 1.0)
    var backgroundBrown = UIColor(red: 206/255.0, green: 150/255.0, blue: 98/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = feedImage.frame.size
        
        archiveView.alpha = 0
        laterView.alpha = 0
        
        messageOffset = 320
        messageOriginalCenter = messageView.center
        messageRight = CGPoint(x: messageView.center.x + messageOffset ,y: messageView.center.y)
        messageLeft = CGPoint(x: messageView.center.x - messageOffset ,y: messageView.center.y)
    
    }
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)

        
        if sender.state == UIGestureRecognizerState.Began {
        
//           messageOriginalCenter = messageView.center
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            // Pan Right
            if translation.x > 60 {
               
                UIView.animateWithDuration(0.2, animations: { 
                    self.archiveView.alpha = 1
                })
                
                if translation.x > 260 {
                    messageViewContainer.backgroundColor = backgroundRed
                } else {
                    messageViewContainer.backgroundColor = backgroundGreen
                }
                
            } else {
//                messageViewContainer.backgroundColor = backgroundGrey
                self.archiveView.alpha = 0

            }
            
            // Pan left
            if translation.x < -60 {
                laterView.alpha = 1
                
                if translation.x < -260 {
                    messageViewContainer.backgroundColor = backgroundBrown
                } else {
                    messageViewContainer.backgroundColor = backgroundYellow
                }
                
            } else {
                
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended")
            
            if translation.x > 60 {
                print("greater than 60")

                UIView.animateWithDuration(0.2, animations: {
                    self.messageView.center = self.messageRight
                })
            } else {
                UIView.animateWithDuration(0.2, animations: {
                    self.messageView.center = self.messageOriginalCenter

                })
            }
            
            // Pan left
            if translation.x < -60 {
                
                UIView.animateWithDuration(0.2, animations: {
                    self.messageView.center = self.messageLeft
                })

               
            } else {

                
            }

            

            }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
