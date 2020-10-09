//
//  UINavigationController+LDRExtension.h
//  LDRenting
//
//  Created by MAC on 2020/7/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (LDRExtension)
+ (UINavigationController *)currentNC;
+ (UIViewController *)findVisibleViewController;

@end

NS_ASSUME_NONNULL_END
