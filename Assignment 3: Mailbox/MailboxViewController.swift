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
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var reschedueView: UIImageView!
    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var DeleteView: UIImageView!
    @IBOutlet weak var leftIconView: UIView!
    @IBOutlet weak var rightIconView: UIView!
    @IBOutlet weak var actionScreens: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var mainView: UIView!
    
    // Message Position Variables
    var messageOriginalCenter: CGPoint!
    var messageRight: CGPoint!
    var messageLeft: CGPoint!
    var messageOffset: CGFloat!
    
    var mainViewOriginalCenter: CGPoint!
    var mainViewOffset: CGFloat!
    var mainViewRight: CGPoint!
    
    var feedImageOriginalCenter: CGPoint!
    
    
    // Icon Position Variables
    var leftIconViewriginalCenter: CGPoint!
    var rightIconViewOriginalCenter: CGPoint!
    
    
    // Color Variables
    var backgroundRed = UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
    var backgroundGreen = UIColor(red: 25/255.0, green: 156/255.0, blue: 54/255.0, alpha: 1.0)
    var backgroundGrey = UIColor(red: 219/255.0, green: 219/255.0, blue: 219/255.0, alpha: 1.0)
    var backgroundYellow = UIColor(red: 248/255.0, green: 203/255.0, blue: 39/255.0, alpha: 1.0)
    var backgroundBrown = UIColor(red: 206/255.0, green: 150/255.0, blue: 98/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = feedImage.frame.size
        
        //Initial Alphas
        archiveView.alpha = 1
        laterView.alpha = 1
        listView.alpha = 0
        reschedueView.alpha = 0
        listIconView.alpha = 0
        DeleteView.alpha = 0
        rightIconView.alpha = 0
        leftIconView.alpha = 0
        actionScreens.alpha = 0
        
        segmentControl.selectedSegmentIndex = 1
        
        mainViewOriginalCenter = mainView.center
        
        feedImageOriginalCenter = feedImage.center
        
    
        
    }
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
//        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
        
            //Moving Message Setup
            messageOffset = 320
            messageOriginalCenter = messageView.center
            messageRight = CGPoint(x: messageView.center.x + messageOffset ,y: messageView.center.y)
            messageLeft = CGPoint(x: messageView.center.x - messageOffset ,y: messageView.center.y)
            
            //Moving Icon Setup
            leftIconViewriginalCenter = leftIconView.center
            rightIconViewOriginalCenter = rightIconView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            if messageView.center.x > messageOriginalCenter.x {
                //Move Message Right
                
                //Alpha control for icon
                let progress = convertValue(abs(translation.x), r1Min: 0, r1Max: 60, r2Min: 0, r2Max: 1)
                leftIconView.alpha = progress
                
                //Back to grey
                UIView.animateWithDuration(0.1, animations: {
                    self.messageViewContainer.backgroundColor = self.backgroundGrey

                })

                
                if abs(translation.x) >= 60 {
                    
                    //move icon
                    leftIconView.center = CGPoint(x: leftIconViewriginalCenter.x + translation.x - 60, y: leftIconViewriginalCenter.y)
                   
                    //change to green
                    messageViewContainer.backgroundColor = backgroundGreen
                    
                    //Switch Icon back to archive
                    archiveView.alpha = 1
                    DeleteView.alpha = 0

                    
                    if abs(translation.x) >= 260 {
                        
                        //Switch Icon back to delete
                        archiveView.alpha = 0
                        DeleteView.alpha = 1
                        
                        // background color to red
                        messageViewContainer.backgroundColor = backgroundRed
                    }
                }

                
                } else {
                    //Move Left
                
                    //Alpha control for icon
                    let progress = convertValue(abs(translation.x), r1Min: 0, r1Max: 60, r2Min: 0, r2Max: 1)
                    rightIconView.alpha = progress
                
                    //Back to grey
                    UIView.animateWithDuration(0.1, animations: {
                        self.messageViewContainer.backgroundColor = self.backgroundGrey
                    
                    })

                
                    if abs(translation.x) >= 60 {
                        //move icon
                        rightIconView.center = CGPoint(x: rightIconViewOriginalCenter.x + translation.x + 60, y: rightIconViewOriginalCenter.y)
                        
                        //Switch Icon back to clock
                        laterView.alpha = 1
                        listIconView.alpha = 0
                        
                        //change to yellow
                        messageViewContainer.backgroundColor = backgroundYellow
                        
                        if abs(translation.x) >= 260 {
                            
                            //Switch Icon back to list
                            laterView.alpha = 0
                            listIconView.alpha = 1
                            
                            // background color to brown
                            messageViewContainer.backgroundColor = backgroundBrown
                        }
                    }
                }
            
            
            } else if sender.state == UIGestureRecognizerState.Ended {
            
                //reset icon views
                rightIconView.alpha = 0
                leftIconView.alpha = 0
            
                rightIconView.center = rightIconViewOriginalCenter
                leftIconView.center = leftIconViewriginalCenter
            
            
                if messageView.center.x > messageOriginalCenter.x {
                    if abs(translation.x) >= 60 {
                        if abs(translation.x) >= 260 {
                            //delete message and move feed up
                            UIView.animateWithDuration(0.2, animations: {
                                self.messageView.center = self.messageRight
                                self.feedImage.center.y = self.feedImage.center.y - 86
                                self.messageViewContainer.backgroundColor = self.backgroundRed
                                
                            })
                        
                        } else {
                            //archive message and move feed up
                            UIView.animateWithDuration(0.2, animations: {
                                self.messageView.center = self.messageRight
                                self.feedImage.center.y = self.feedImage.center.y - 86
                                self.messageViewContainer.backgroundColor = self.backgroundGreen
                                
                            })
                        }
                        
                       
                    } else {
                        //move message back to center
                        UIView.animateWithDuration(0.2, animations: { 
                            self.messageView.center = self.messageOriginalCenter

                        })
                    }
                } else {
                    if abs(translation.x) >= 60 {
                       
                        //make parent view visible
                        actionScreens.alpha = 1
                        
                        if abs(translation.x) >= 260 {
                            //mmove message left and show list view
                            UIView.animateWithDuration(0.2, animations: {
                                self.messageView.center = self.messageLeft
                                self.listView.alpha = 1
                            })
                        } else {
                            //mmove message left and show later view
                            UIView.animateWithDuration(0.2, animations: {
                                self.messageView.center = self.messageLeft
                                self.reschedueView.alpha = 1
                            })
                        }
                        

                    } else {
                        //move messasge back to center
                        UIView.animateWithDuration(0.2, animations: {
                            self.messageView.center = self.messageOriginalCenter
                            
                        })

                    }
            }
        
        }
        }
    
    @IBAction func didCloseActions(sender: AnyObject) {
        
        //Close menu for list/later
        UIView.animateWithDuration(0.2, animations: {
            self.messageView.center = self.messageOriginalCenter
            self.listView.alpha = 0
            self.reschedueView.alpha = 0
            self.actionScreens.alpha = 0
        })
        
    }

    @IBAction func didPanScreen(sender: UIScreenEdgePanGestureRecognizer) {

        //Pan to reveal menu from left edge
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        
        mainView.center = CGPoint(x: mainViewOriginalCenter.x + translation.x, y: mainViewOriginalCenter.y)

        if sender.state == .Began {
            print("edge pan start")
        }
        else if sender.state == .Changed {
            print("edge pan change")
        } else if sender.state == .Ended {
            print("edge pan end")
            if velocity.x > 0 {
                UIView.animateWithDuration(0.2, animations: {
                    self.mainView.center.x = 440
                })
            } else{
                UIView.animateWithDuration(0.2, animations: {
                    self.mainView.center = self.mainViewOriginalCenter
                })
            }

        
        }
        
    }
    
    @IBAction func didCloseMenu(sender: AnyObject) {
        
        //Close menu
        UIView.animateWithDuration(0.2, animations: {
            self.mainView.center = self.mainViewOriginalCenter
        })
        
    }
    
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
       
        //Reverse Deleteion via Shake
        self.messageView.center = self.messageOriginalCenter

        UIView.animateWithDuration(0.2, animations: {
            self.feedImage.center = self.feedImageOriginalCenter
            self.messageViewContainer.backgroundColor = self.backgroundGrey
            
        })

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
