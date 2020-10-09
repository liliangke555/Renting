//
//  LDRRootController.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRootController.h"
#import "LDRTabBarController.h"
#import "MMAlertView.h"

@interface LDRRootController ()<UITabBarControllerDelegate,CYLTabBarControllerDelegate>

@end

@implementation LDRRootController

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    BOOL hn_should = YES;
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController shouldSelect:hn_should];
    return hn_should;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *hn_animationView;
    if ([control cyl_isTabButton]) {
        hn_animationView = [control cyl_tabImageView];
    }
    if ([control cyl_isPlusButton]) {
        UIButton *button = CYLExternPlusButton;
        hn_animationView = button.imageView;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBarHidden = YES;
    [self tabbarController];
    id state = [[NSUserDefaults standardUserDefaults] objectForKey:LDRLoginState];
    if (!state) {
        [self shouUserAgreement];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)shouUserAgreement
{
    LDRWeakify(self);
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            [weakSelf showReconfirmAlertView];
        } else {
            
        }
    };
    NSArray *items =@[MMItemMake(@"不同意", MMItemTypeNormal, block),
                      MMItemMake(@"同意", MMItemTypeNormal, block)];
    LDRAlterView *alertView = [[LDRAlterView alloc] initWithTitle:@"360租房《用户服务协议》\n及《隐私政策》"
                                                         detail:@"欢迎来到360租房，我们重视与保障您的个人隐私及其他相关权益，特向你说明如下限制：\n\n1.请务必认真阅读和理解《【360租房】软件安装许可协议》中规定的所有权利和限制。\n\n2.360租房非常重视客户个人信息及隐私权的保护，因此我门制定了涵盖如何收集、存储、使用、共享和保护客户信息的隐私政策。\n\n3.如果您不同意本协议中的条款，请不要安装、复制或使用本软件。\n\n以下为完整的《用户协版》和《隐私政策》，请您仔细阅读。\n\n您可以阅读完整版《用户服务协议》及《隐私政策》"
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    [alertView show];
}
- (void)showReconfirmAlertView
{
    MMPopupItemHandler block = ^(NSInteger index){
            NSLog(@"clickd %@ button",@(index));
        if (index == 0) {
            exit(0);
        } else {
            
        }
    };
    NSArray *items =@[MMItemMake(@"退出应用", MMItemTypeNormal, block),
                      MMItemMake(@"查看协议", MMItemTypeNormal, block)];
    LDRAlterView *alertView = [[LDRAlterView alloc] initWithTitle:@"您需要同意本隐私政策才能\n继续使用360租房"
                                                         detail:@"若您不同意本隐私政策，很遗憾我们将无法为您提供服务"
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    [alertView show];
}
- (LDRTabBarController *)tabbarController{
    LDRTabBarController *tabBarController = [[LDRTabBarController alloc] init];
    tabBarController.delegate = self;
    self.viewControllers = @[tabBarController];
    return tabBarController;
}

@end
