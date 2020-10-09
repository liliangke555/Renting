//
//  LDRRootConfig.h
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRRootConfig : NSObject

+ (instancetype)sharedRootConfig;

- (void)setupRootWindow:(UIWindow*)window;
//- (void)starLaunchImageView:(UIWindow *)window;

- (void)toLogin;

- (void)presentNavogationViewController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
