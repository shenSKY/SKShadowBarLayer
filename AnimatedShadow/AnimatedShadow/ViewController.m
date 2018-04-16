//
//  ViewController.m
//  AnimatedShadow
//
//  Created by 沈凯 on 2018/4/16.
//  Copyright © 2018年 Ssky. All rights reserved.
//

#import "ViewController.h"
#import "SKShadowBarLayer.h"

@interface ViewController ()<SKShadowBarLayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) SKShadowBarLayer *shadow;
@property (strong, nonatomic) SKShadowBarLayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width_Screen = [UIScreen mainScreen].bounds.size.width;
    CGFloat height_Screen = [UIScreen mainScreen].bounds.size.height;
    self.shadow = [SKShadowBarLayer new];
//    设置颜色
    self.shadow.fillColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:25/255.0 alpha:1.0].CGColor;
//    设置大小
    [self.shadow setFrame:(CGRect){0, 0, width_Screen * 0.8, width_Screen * 0.8 / 32 * 15}];
//    设置透明度
    self.shadow.opacity = 0.6;
    [self.imageView.layer addSublayer:self.shadow];
    
    self.layer = [SKShadowBarLayer new];
//    设置颜色
    self.layer.fillColor = [UIColor redColor].CGColor;
    self.layer.backgroundColor = [UIColor blackColor].CGColor;
//    设置大小
    [self.layer setFrame:(CGRect){width_Screen * 0.1, height_Screen / 2.5, width_Screen * 0.8, 20}];
//    设置透明度
    self.layer.opacity = 1;

    [self.view.layer addSublayer:self.layer];
    
    self.layer.shadowDelegate = self;
}
- (IBAction)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            [self.shadow beginAnimationWithDuration:30];
            [self.layer beginAnimationWithDuration:30];
            break;
        case 2:
            [self.shadow pauseAnimation];
            [self.layer pauseAnimation];
            break;
        case 3:
            [self.shadow resumeAnimation];
            [self.layer resumeAnimation];
            break;
        case 4:
            [self.shadow restartAnimationWithDuration:30 progress:0];
            [self.layer restartAnimationWithDuration:30 progress:0];
            break;
        default:
            break;
    }
}
#pragma mark delegate
- (void)animationDidStart {
    NSLog(@"开始");
}
- (void)animationDidStop {
    NSLog(@"停止");
}
- (void)animationDidComplete {
    NSLog(@"完成");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
