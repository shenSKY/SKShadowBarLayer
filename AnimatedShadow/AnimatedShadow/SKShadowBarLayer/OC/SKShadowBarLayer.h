//
//  SKShadowBarLayer.h
//
//  Created by 沈凯 on 2018/4/13.
//  Copyright © 2018年 Ssky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SKAnimationStatus) {
//    Animation Status is Free.
    SKAnimationStatusFree,
//    Animation Status is Animating.
    SKAnimationStatusAnimating,
//    Animation Status is Pause.
    SKAnimationStatusPause,
//    Animation Status is Complete.
    SKAnimationStatusComplete
};

@protocol SKShadowBarLayerDelegate <NSObject>
@optional
- (void)animationDidStart;

- (void)animationDidStop;

- (void)animationDidComplete;

@end

@interface SKShadowBarLayer : CAShapeLayer

@property (nonatomic, assign, readonly) SKAnimationStatus animatingStatus;//状态
@property(nonatomic,weak)id<SKShadowBarLayerDelegate> shadowDelegate;
/**
 Begin Animation
 @param duration Animation duration
 */
- (void)beginAnimationWithDuration:(CGFloat)duration;

/**
 Pause Animation
 */
- (void)pauseAnimation;

/**
 Resume Animation
 */
- (void)resumeAnimation;

/**
 Restart Animation

 @param progress Start Progress
 @param duration Animation duration
 */
- (void)restartAnimationWithDuration:(CGFloat)duration progress:(CGFloat)progress;
@end
