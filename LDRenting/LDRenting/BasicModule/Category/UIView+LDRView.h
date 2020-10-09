//
//  UIView+LDRView.h
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LDRView)

- (void)clipCorners:(UIRectCorner)corners radius:(CGFloat)radius;
- (void)clipCorners:(UIRectCorner)corners radius:(CGFloat)radius border:(CGFloat)width color:(nullable UIColor *)color;

@end

NS_ASSUME_NONNULL_END
