//
//  UIView+LDRView.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "UIView+LDRView.h"

@implementation UIView (LDRView)

- (void)clipCorners:(UIRectCorner)corners radius:(CGFloat)radius
{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:(CGSize){radius}];
    CAShapeLayer *shapeLayer = self.layer.mask ?: [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}

- (void)clipCorners:(UIRectCorner)corners radius:(CGFloat)radius border:(CGFloat)width color:(UIColor *)color
{
    
    [self clipCorners:corners radius:radius];
    
    CAShapeLayer *subLayer = [CAShapeLayer layer];
    subLayer.lineWidth = width * 2;
    subLayer.strokeColor = color.CGColor;
    subLayer.fillColor = [UIColor clearColor].CGColor;
    subLayer.path = ((CAShapeLayer *)self.layer.mask).path;
    [self.layer addSublayer:subLayer];
}

@end
