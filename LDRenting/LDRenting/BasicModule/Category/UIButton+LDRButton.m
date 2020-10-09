//
//  UIButton+LDRButton.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "UIButton+LDRButton.h"

@implementation UIButton (LDRButton)

+ (instancetype)buttonWithTarget:(id)target action:(SEL)sel
{
    id btn = [self buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn setExclusiveTouch:YES];
    return btn;
}

+ (instancetype)mainButtonWithTarget:(id)target action:(SEL)sel
{
    UIButton *btn = [self buttonWithTarget:target action:sel];
    [btn setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateHighlighted];
    [btn.titleLabel setFont:LDRFont14];
    [btn.layer setCornerRadius:LDRRadius];
    [btn setClipsToBounds:YES];
    return btn;
}

+ (instancetype)viceButtonWithTarget:(id)target action:(SEL)sel
{
    UIButton *btn = [self buttonWithTarget:target action:sel];
    [btn setBackgroundImage:[UIImage ldr_imageWithColor:LDR_GrayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage ldr_imageWithColor:LDR_TextLightGrayColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:LDRFont14];
    [btn.layer setCornerRadius:LDRRadius];
    [btn setClipsToBounds:YES];
    return btn;
}

@end
