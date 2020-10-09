//
//  UIButton+LDRButton.h
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LDRButton)

+ (instancetype)buttonWithTarget:(id)target action:(SEL)sel;
+ (instancetype)mainButtonWithTarget:(id)target action:(SEL)sel;
+ (instancetype)viceButtonWithTarget:(id)target action:(SEL)sel;
@end

NS_ASSUME_NONNULL_END
