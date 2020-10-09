//
//  LDRHUD+HUD.m
//  LDRenting
//
//  Created by MAC on 2020/7/23.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHUD+HUD.h"
#import <Lottie/Lottie.h>

@implementation LDRHUD (HUD)

+ (void)showSuccessfulWithMessage:(NSString *)message view:(UIView *_Nullable)view
{
    if (!view) {
        view = LDR_Window;
    }
    LOTAnimationView *animationView = [LOTAnimationView animationWithFilePath:[[NSBundle mainBundle] pathForResource:@"lf30_editor_SbFWzN" ofType:@"json"]];
    LDRHUD *hud = [LDRHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = animationView;
    hud.label.text = message;
    hud.minSize = CGSizeMake(120, 120);
    [hud.label setFont:LDRFont12];
    hud.label.numberOfLines = 2;
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithHex:0x000000BF];
    [hud hideAnimated:YES afterDelay:1.f];
    [animationView play];
}

+ (void)showHUDWithMessage:(NSString *)message toView:(UIView * _Nullable )view
{
    if (!view) {
        view = LDR_Window;
    }
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    [view addSubview:hud];
    hud.label.text = message;
    hud.label.numberOfLines = 3;
    [hud.label setFont:LDRFont14];
    hud.mode = MBProgressHUDModeText;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithHex:0x000000BF];
    hud.offset = CGPointMake(0, (265 / 812.0f) * LDR_HEIGHT);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [hud hideAnimated:YES afterDelay:1.5f];
}
+ (void)showHUDWithMessage:(NSString *)message
{
    [self showHUDWithMessage:message toView:nil];
}
+ (void)showBlueToothConnectingInView:(UIView * _Nullable )view
{
    if (!view) {
        view = LDR_Window;
    }
    LOTAnimationView *animationView = [LOTAnimationView animationWithFilePath:[[NSBundle mainBundle] pathForResource:@"lf20_fZxqhq" ofType:@"json"]];
    animationView.loopAnimation = YES;
    animationView.animationSpeed = 0.5;
    LDRHUD *hud = [LDRHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = animationView;
    hud.minSize = CGSizeMake(120, 120);
    hud.label.text = @"蓝牙连接中";
    [hud.label setFont:LDRFont12];
    hud.label.numberOfLines = 2;
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithHex:0x000000BF];
    [animationView play];
}

+ (void)showLoadingInView:(UIView * _Nullable )view
{
    if (!view) {
        view = LDR_Window;
    }
    LOTAnimationView *animationView = [LOTAnimationView animationWithFilePath:[[NSBundle mainBundle] pathForResource:@"lf20_RZPIuU" ofType:@"json"]];
    animationView.loopAnimation = YES;
//    animationView.animationSpeed = 0.5;
    LDRHUD *hud = [LDRHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = animationView;
    hud.minSize = CGSizeMake(120, 120);
    hud.label.text = @"请稍等";
    [hud.label setFont:LDRFont12];
    hud.label.numberOfLines = 2;
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithHex:0x000000BF];
    [animationView play];
}


+ (void)hideHUD{
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView * __nullable)view{
    if (!view){
        view = LDR_Window;
    }
    [self hideHUDForView:view animated:YES];
}
@end
