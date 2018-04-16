//
//  SKShadowBarLayer.m
//
//  Created by 沈凯 on 2018/4/13.
//  Copyright © 2018年 Ssky. All rights reserved.
//

#import "SKShadowBarLayer.h"

@interface SKShadowBarLayer ()<CAAnimationDelegate>

@end

@implementation SKShadowBarLayer

- (void)beginAnimationWithDuration:(CGFloat)duration
{
    [self startAnimtionWithBeginDuration:duration progress:0];
}

- (void)pauseAnimation
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
    self.animatingStatus = SKAnimationStatusPause;
}

- (void)resumeAnimation
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
    
    self.animatingStatus = SKAnimationStatusAnimating;
}

- (void)restartAnimationWithDuration:(CGFloat)duration progress:(CGFloat)progress
{
    [self removeAllAnimations];
    [self startAnimtionWithBeginDuration:duration progress:progress];
}

#pragma mark - private method
- (void)reset
{
    [self removeAllAnimations];
    self.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 0, self.bounds.size.height)].CGPath;
    self.speed = 1.0;
    self.beginTime = 0.0;
}

- (void)startAnimtionWithBeginDuration:(CGFloat)duration progress:(CGFloat)beginProgress
{
//    Reset Animtion
    [self reset];
//    Set Path
    UIBezierPath *fromPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, beginProgress * self.bounds.size.width, self.bounds.size.height)];;
    UIBezierPath *toPath = [UIBezierPath bezierPathWithRect:self.bounds];
    
    self.path = fromPath.CGPath;
//    Create Animtion
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (id)fromPath.CGPath;
    animation.toValue = (id)toPath.CGPath;
    animation.duration = duration;
//    Start of the animation
    [animation setValue:@1 forKey:@"progress"];
//    End of the animation
    animation.delegate = self;
    [self addAnimation:animation forKey:@"progressAnimation"];
    
    self.path = toPath.CGPath;
}

#pragma mark - setter
- (void)setAnimatingStatus:(SKAnimationStatus)animatingStatus
{
    _animatingStatus = animatingStatus;
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    if (anim == [self animationForKey:@"progressAnimation"]) {
        self.animatingStatus = SKAnimationStatusAnimating;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim valueForKey:@"progress"] && flag == YES) {
        self.animatingStatus = SKAnimationStatusComplete;
    }
}
@end
