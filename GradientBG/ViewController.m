//
//  ViewController.m
//  T
//
//  Created by Aegaeon on 23/05/2017.
//  Copyright © 2017 Aegaeon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CAAnimationDelegate>
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) NSArray<UIColor *> *colors;
@property (nonatomic, assign) int currentGradientIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.layer insertSublayer:self.gradientLayer atIndex:0];
    [self doAnimation];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.gradientLayer.frame = self.view.bounds;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = [self currentGradient];
        _gradientLayer.startPoint = CGPointMake(0.0, 1.0);
        _gradientLayer.endPoint = CGPointMake(1.0, 0.0);
        _gradientLayer.drawsAsynchronously = YES;
    }
    return _gradientLayer;
}

- (void)doAnimation {
    self.currentGradientIndex += 1;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.duration = 2.0;
    animation.toValue = [self currentGradient];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [self.gradientLayer addAnimation:animation forKey:@"ColorChange"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        self.gradientLayer.colors = [self currentGradient];
        [self doAnimation];
    }
}

- (NSArray <UIColor*> *)colors {
    if (!_colors) {
        _colors = @[[UIColor colorWithRed:156 * 1.0/255 green:39 * 1.0/255 blue:176 * 1.0/255 alpha:1.0],
                    [UIColor colorWithRed:255 * 1.0/255 green:64 * 1.0/255 blue:129 * 1.0/255 alpha:1.0],
                    [UIColor colorWithRed:123 * 1.0/255 green:31 * 1.0/255 blue:162 * 1.0/255 alpha:1.0],
                    [UIColor colorWithRed:32 * 1.0/255 green:76 * 1.0/255 blue:255 * 1.0/255 alpha:1.0],
                    [UIColor colorWithRed:32 * 1.0/255 green:158 * 1.0/255 blue:255 * 1.0/255 alpha:1.0],
                    [UIColor colorWithRed:90 * 1.0/255 green:120 * 1.0/255 blue:127 * 1.0/255 alpha:1.0],
                    [UIColor colorWithRed:58 * 1.0/255 green:255 * 1.0/255 blue:217 * 1.0/255 alpha:1.0]];
    }
    return _colors;
}

- (NSArray *)currentGradient {
    return @[(id)self.colors[self.currentGradientIndex % self.colors.count].CGColor, (id)self.colors[(self.currentGradientIndex + 1) % self.colors.count].CGColor];
}

@end
