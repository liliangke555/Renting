//
//  UIViewController+LDRNavigationItem.h
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LDRNavigationItem)

- (void)addRightBarButtonWithFirstImage:(UIImage *)firstImage action:(SEL)action;
- (void)addRightBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor;


-(void)setNavTitle:(NSString *)title withAction:(SEL)action;
- (void)addRightTwoBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction;
- (void)addLeftBarButtonWithImage:(UIImage *)image action:(SEL)action;
-(void)setNavTitle:(NSString *)title withColor:(UIColor *)color action:(SEL)action;
- (void)addRightThreeBarButtonsWithFirstImage:(UIImage *)firstImage firstAction:(SEL)firstAction secondImage:(UIImage *)secondImage secondAction:(SEL)secondAction thirdImage:(UIImage *)thirdImage thirdAction:(SEL)thirdAction;

- (void)addLeftBarButtonItemWithTitle:(NSString *)itemTitle action:(SEL)action;

-(void)setNavTitle:(NSString *)title withColor:(UIColor *)color;
-(void)setNavTitle:(NSString *)title;

- (void)addRightBarButtonItemWithImage:(UIImage *)image action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
