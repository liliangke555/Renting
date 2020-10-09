//
//  LDRHUD+HUD.h
//  LDRenting
//
//  Created by MAC on 2020/7/23.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRHUD (HUD)
/// 成功 HUD
/// @param message 消息
/// @param view 加载的View
+ (void)showSuccessfulWithMessage:(NSString *)message view:(UIView * _Nullable )view;

+ (void)showHUDWithMessage:(NSString *)message;

+ (void)showHUDWithMessage:(NSString *)message toView:(UIView * _Nullable )view;

/// 蓝牙连接中 HUD
/// @param view 加载的View
+ (void)showBlueToothConnectingInView:(UIView * _Nullable )view;

+ (void)showLoadingInView:(UIView * _Nullable )view;

/// 隐藏提示
+ (void)hideHUD;

/// 隐藏提示
/// @param view 视图
+ (void)hideHUDForView:(UIView *__nullable)view;
@end

NS_ASSUME_NONNULL_END
