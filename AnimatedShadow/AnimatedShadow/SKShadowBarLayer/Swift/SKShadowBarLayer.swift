//
//  SKShadowBarLayer.swift
//
//  Created by 沈凯 on 2018/4/13.
//  Copyright © 2018年 Ssky. All rights reserved.
//

import UIKit
enum SKAnimationStatus : Int {
//    Animation Status is Free.
    case free
//    Animation Status is Animating.
    case animating
//    Animation Status is Pause.
    case pause
//    Animation Status is Complete.
    case complete
    
}
class SKShadowBarLayer: CAShapeLayer ,CAAnimationDelegate {
//    Animation Status
    private(set) var animatingStatus: SKAnimationStatus!
//    MARK: - Begin Animation
    func beginAnimation(duration: CGFloat) {
        startAnimtion(duration: duration, progress: 0)
    }
//    MARK: - Pause Animation
    func pauseAnimation() {
        let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
        animatingStatus = SKAnimationStatus.pause
    }
//    MARK: - Resume Animation
    func resumeAnimation() {
        let pausedTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
        animatingStatus = SKAnimationStatus.animating
    }
//    MARK: - Restart Animation
    func restartAnimation(duration: CGFloat, progress: CGFloat) {
        removeAllAnimations()
        startAnimtion(duration: duration, progress: progress)
    }
    
    private func reset() {
        removeAllAnimations()
        path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 0, height: bounds.size.height)).cgPath
        speed = 1.0
        beginTime = 0.0
    }
    private func startAnimtion(duration: CGFloat, progress: CGFloat) {
//        Reset Animtion
        reset()
//        Set Path
        let fromPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: progress * bounds.size.width, height: bounds.size.height))
        let toPath = UIBezierPath(rect: bounds)
        path = fromPath.cgPath
//        Create Animtion
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = fromPath.cgPath
        animation.toValue = toPath.cgPath
        animation.duration = CFTimeInterval(duration)
//        Start of the animation
        animation.setValue(1, forKey: "progress")
        animation.delegate = self
//        End of the animation
        add(animation, forKey: "progressAnimation")
        path = toPath.cgPath
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        if anim == animation(forKey: "progressAnimation") {
            animatingStatus = SKAnimationStatus.animating
        }
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == animation(forKey: "progress") && flag == true {
            animatingStatus = SKAnimationStatus.complete
        }
    }
}
