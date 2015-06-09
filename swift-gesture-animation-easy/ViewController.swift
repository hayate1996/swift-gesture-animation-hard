//
//  ViewController.swift
//  swift-gesture-animation-easy
//
//  Created by Hiromasa Nagamine on 5/31/15.
//  Copyright (c) 2015 hiro nagami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var leftUpFrame: UIView!
    var rightUpFrame: UIView!
    var leftDownFrame: UIView!
    var rightDownFrame: UIView!
    var rect:UIView!
    let duration: NSTimeInterval = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureViews()
        configureGestures()
    }

    func configureViews()
    {
        leftUpFrame = UIView(frame: CGRectMake(0, 0, 80, 80))
        leftUpFrame.layer.borderColor = UIColor.lightGrayColor().CGColor
        leftUpFrame.layer.borderWidth = 1.0
        leftUpFrame.center = CGPointMake(self.view.center.x - 100, self.view.center.y - 100)
        
        rightUpFrame = UIView(frame: CGRectMake(0, 0, 80, 80))
        rightUpFrame.layer.borderColor = UIColor.lightGrayColor().CGColor
        rightUpFrame.layer.borderWidth = 1.0
        rightUpFrame.layer.cornerRadius = 40.0
        rightUpFrame.center = CGPointMake(self.view.center.x + 100, self.view.center.y - 100)
        
        leftDownFrame = UIView(frame: CGRectMake(0, 0, 80, 80))
        leftDownFrame.layer.borderColor = UIColor.lightGrayColor().CGColor
        leftDownFrame.layer.borderWidth = 1.0
        leftDownFrame.layer.cornerRadius = 40.0
        leftDownFrame.center = CGPointMake(self.view.center.x - 100, self.view.center.y + 100)
        
        rightDownFrame = UIView(frame: CGRectMake(0, 0, 80, 80))
        rightDownFrame.layer.borderColor = UIColor.lightGrayColor().CGColor
        rightDownFrame.layer.borderWidth = 1.0
        rightDownFrame.center = CGPointMake(self.view.center.x + 100, self.view.center.y + 100)
        
        
        rect = UIView(frame: CGRectMake(0, 0, 75, 75))
        rect.backgroundColor = UIColor.blueColor()
        rect.center = leftUpFrame.center
        
        self.view.addSubview(leftUpFrame)
        self.view.addSubview(rightUpFrame)
        self.view.addSubview(leftDownFrame)
        self.view.addSubview(rightDownFrame)
        self.view.addSubview(rect)
    }
    
    func configureGestures()
    {
        var swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: Selector("callSwipeLeftAnimation"))
        swipeGestureRecognizerLeft.direction = .Left
        rect.addGestureRecognizer(swipeGestureRecognizerLeft)
        
        var swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: Selector("callSwipeRightAnimation"))
        swipeGestureRecognizerRight.direction = .Right
        rect.addGestureRecognizer(swipeGestureRecognizerRight)
        
        var swipeGestureRecognizerUp = UISwipeGestureRecognizer(target: self, action: Selector("callSwipeUpAnimation"))
        swipeGestureRecognizerUp.direction = .Up
        rect.addGestureRecognizer(swipeGestureRecognizerUp)
        
        var swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: Selector("callSwipeDownAnimation"))
        swipeGestureRecognizerDown.direction = .Down
        rect.addGestureRecognizer(swipeGestureRecognizerDown)
    }
    
    func callSwipeLeftAnimation()
    {
        if self.rect.center == self.rightDownFrame.center {
            self.setCornerRadiusAnimation()
        }
        else {
            self.resetCornerRadiusAnimation()
        }

        UIView.animateWithDuration(duration, animations: { () -> Void in
            if self.rect.center == self.rightUpFrame.center {
                self.rect.center = self.leftUpFrame.center
            }
            else if self.rect.center == self.rightDownFrame.center {
                self.rect.center = self.leftDownFrame.center
            }
        })
    }
    
    func callSwipeRightAnimation()
    {
        if self.rect.center == self.leftUpFrame.center {
            self.setCornerRadiusAnimation()
        }
        else {
            self.resetCornerRadiusAnimation()
        }

        UIView.animateWithDuration(duration, animations: { () -> Void in
            if self.rect.center == self.leftUpFrame.center {
                self.rect.center = self.rightUpFrame.center
            }
            else if self.rect.center == self.leftDownFrame.center {
                self.rect.center = self.rightDownFrame.center
            }
        })
    }
    
    func callSwipeUpAnimation()
    {
        if self.rect.center == self.rightDownFrame.center {
            self.setCornerRadiusAnimation()
        }
        else {
            self.resetCornerRadiusAnimation()
        }

        UIView.animateWithDuration(duration, animations: { () -> Void in
            if self.rect.center == self.leftDownFrame.center {
                self.rect.center = self.leftUpFrame.center
            }
            else if self.rect.center == self.rightDownFrame.center {
                self.rect.center = self.rightUpFrame.center
            }
        })
    }
    
    func callSwipeDownAnimation()
    {
        if self.rect.center == self.leftUpFrame.center {
            self.setCornerRadiusAnimation()
        }
        else {
            self.resetCornerRadiusAnimation()
        }

        UIView.animateWithDuration(duration, animations: { () -> Void in
            if self.rect.center == self.leftUpFrame.center {
                self.rect.center = self.leftDownFrame.center
            }
            else if self.rect.center == self.rightUpFrame.center {
                self.rect.center = self.rightDownFrame.center
            }
        })
    }
    
    func setCornerRadiusAnimation()
    {
        // cornerRadiusを変更するアニメーション
        var cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")

        // cornerRadius を 0 -> 37.5 に変化させるよう設定
        cornerRadiusAnimation.fromValue = 0
        cornerRadiusAnimation.toValue = 75.0 / 2.0

        // アニメーション
        cornerRadiusAnimation.duration = duration

        // アニメーションが終了した時の状態を維持する
        cornerRadiusAnimation.removedOnCompletion = false
        cornerRadiusAnimation.fillMode = kCAFillModeForwards

        // アニメーションが終了したらanimationDidStopを呼び出す
        cornerRadiusAnimation.delegate = self

        // アニメーションの追加
        rect.layer.addAnimation(cornerRadiusAnimation, forKey: "cornerRadiusAnimation")
    }

    func resetCornerRadiusAnimation()
    {
        // cornerRadiusを変更するアニメーション
        var cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")

        // cornerRadius を 37.5 -> 0 に変化させるよう設定
        cornerRadiusAnimation.fromValue = 75.0 / 2.0
        cornerRadiusAnimation.toValue = 0

        // アニメーション
        cornerRadiusAnimation.duration = duration

        // アニメーションが終了した時の状態を維持する
        cornerRadiusAnimation.removedOnCompletion = false
        cornerRadiusAnimation.fillMode = kCAFillModeForwards

        // アニメーションが終了したらanimationDidStopを呼び出す
        cornerRadiusAnimation.delegate = self

        // アニメーションの追加
        rect.layer.addAnimation(cornerRadiusAnimation, forKey: "cornerRadiusAnimation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

