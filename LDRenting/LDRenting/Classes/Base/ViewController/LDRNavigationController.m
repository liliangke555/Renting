//
//  LDRNavigationController.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRNavigationController.h"
#import "LDRBaseViewController.h"

@interface LDRNavigationController ()

@end

@implementation LDRNavigationController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = @{
        NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
        NSForegroundColorAttributeName : [UIColor colorWithHex:0x000000FF],
    };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}
#pragma mark - Override
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
//        LDRBaseViewController *view = (LDRBaseViewController *)viewController;
        viewController.hidesBottomBarWhenPushed = YES;
//        if (view.isWhiteBack) {
//            viewController.navigationItem.leftBarButtonItem =
//            [UIBarButtonItem ldr_BackItemWithImage:[UIImage imageNamed:@"navigation_back_white"] WithHighlightedImage:[UIImage imageNamed:@"navigation_back_white"] Target:self action:@selector(backController) title:@""];
//        } else {
            viewController.navigationItem.leftBarButtonItem =
                [UIBarButtonItem ldr_BackItemWithImage:[UIImage imageNamed:@"navigation_back_black"] WithHighlightedImage:[UIImage imageNamed:@"navigation_back_black"] Target:self action:@selector(backController) title:@""];
//        }
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark - Action
-(void)backController
{
    [self popViewControllerAnimated:YES];
}
#pragma mark - ovrrideMethod
+ (void)initialize{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        textAttributes = @{
            NSFontAttributeName : [UIFont systemFontOfSize:18.0f],
            NSForegroundColorAttributeName : [UIColor whiteColor],
        };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        textAttributes = @{
            UITextAttributeFont : [UIFont systemFontOfSize:18.0f],
            UITextAttributeTextColor : [UIColor whiteColor],
            UITextAttributeTextShadowColor : [UIColor clearColor],
            UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
        };
#endif
    }
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
