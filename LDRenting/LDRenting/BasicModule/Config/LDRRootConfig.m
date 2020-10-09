//
//  LDRRootConfig.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRootConfig.h"
#import "LDRRootController.h"
#import "LoginViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <ATAuthSDK/ATAuthSDK.h>
#import "LDROneKeyLoginRequest.h"
#import "WXApi.h"
@implementation LDRRootConfig

+ (instancetype)sharedRootConfig
{
    static LDRRootConfig *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LDRRootConfig alloc] init];
    });
    return _instance;
}

- (void)setupKeyBoardManager{
    IQKeyboardManager *jm_keyboardManager = [IQKeyboardManager sharedManager];
    jm_keyboardManager.enable = YES;
    jm_keyboardManager.shouldResignOnTouchOutside = YES;
    jm_keyboardManager.shouldToolbarUsesTextFieldTintColor = NO;
    jm_keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    jm_keyboardManager.enableAutoToolbar = YES;
    jm_keyboardManager.shouldShowToolbarPlaceholder = YES;
    [jm_keyboardManager setToolbarDoneBarButtonItemText:@"完成"];
    jm_keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17];
    jm_keyboardManager.keyboardDistanceFromTextField = 10.0f;
}

- (void)setupRootWindow:(UIWindow *)window{
    window.rootViewController = nil;
    LDRRootController *rootCotroller = [[LDRRootController alloc]init];
    window.rootViewController = rootCotroller;
    [window makeKeyAndVisible];
    
    [self setupKeyBoardManager];

}

/// 苹果登录按钮事件
/// @param sender button
- (void)appleButtonAction:(UIButton *)sender
{
//    [self.view endEditing:YES];
//    [self.navigationController pushViewController:[LDRBindPhoneViewController new] animated:YES];
}

/// 微信登录按钮事件
/// @param sender button
- (void)wechatButtonAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatSuccess:) name:LDRWechatLoginSuccess object:nil];
//    [self.view endEditing:YES];
//    [self.navigationController pushViewController:[LDRBindPhoneViewController new] animated:YES];
    [self sendWXAuthReq];
}
- (void)wechatSuccess:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    
}
- (void)sendWXAuthReq
{
    if([WXApi isWXAppInstalled]){//判断用户是否已安装微信App
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        //唤起微信
        [WXApi sendReq:req completion:^(BOOL success) {
            
        }];
    }else{
        //自己简单封装的alert
        LDRAlterView *alertView = [[LDRAlterView alloc] initWithConfirmTitle:@"温馨提示" detail:@"未安装微信应用或版本过低"];
        [alertView show];
    }
}

- (void)toLogin
{
//    [self oneClick];  //暂时不上
    
    [self presentPhoneNumberLogin];
    
}
- (void)presentPhoneNumberLogin
{
    if ([[UINavigationController findVisibleViewController] isKindOfClass:[LoginViewController class]]) {
        return;
    }
    LoginViewController *vc = [LoginViewController new];
    vc.loginType = LDRLoginTypePhoneNumber;
    LDRNavigationController *nav = [[LDRNavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UINavigationController findVisibleViewController] presentViewController:nav animated:YES completion:nil];
}
- (void)presentNavogationViewController:(UIViewController *)vc
{
    LDRNavigationController *nav = [[LDRNavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UINavigationController findVisibleViewController] presentViewController:nav animated:YES completion:nil];
}
- (void)oneClick
{
    [[TXCommonHandler sharedInstance] setAuthSDKInfo:LDRAliInfo complete:^(NSDictionary * _Nonnull resultDic) {
        NSLog(@"--%@",resultDic);
    }];
    //2. 检测当前环境是否支持一键登录，支不支持提前知道 (PNSAuthTypeLoginToken 检查一键登录环境 PNSAuthTypeVerifyToken 检查号码认证环境)
    __block BOOL support = YES;
    LDRWeakify(self);
    [LDRHUD showLoadingInView:[UINavigationController findVisibleViewController].view];
    [[TXCommonHandler sharedInstance] checkEnvAvailableWithAuthType:PNSAuthTypeLoginToken complete:^(NSDictionary * _Nullable resultDic) {
        support = [PNSCodeSuccess isEqualToString:[resultDic objectForKey:@"resultCode"]];
        if (support) {
            [weakSelf toOneClickLogin];
        } else {
            [LDRHUD hideHUDForView:[UINavigationController findVisibleViewController].view];
            [weakSelf presentPhoneNumberLogin];
        }
    }];
}
- (void)toOneClickLogin
{
    
    LDRWeakify(self);
    [[TXCommonHandler sharedInstance] accelerateLoginPageWithTimeout:3 complete:^(NSDictionary * _Nonnull resultDic) {
        [LDRHUD hideHUDForView:[UINavigationController findVisibleViewController].view];
        if ([PNSCodeSuccess isEqualToString:[resultDic objectForKey:@"resultCode"]] == NO) {
            [weakSelf presentPhoneNumberLogin];
        } else {
            [[TXCommonHandler sharedInstance] getLoginTokenWithTimeout:3 controller:[UINavigationController findVisibleViewController] model:[weakSelf getCustomModel] complete:^(NSDictionary * _Nonnull resultDic) {
                
                //注意回调线程
                NSString *code = [resultDic objectForKey:@"resultCode"];
                if ([PNSCodeLoginControllerPresentSuccess isEqualToString:code]) {
//                    [LDRHUD showHUDWithMessage:@"弹起授权页成功"];
                } else if ([PNSCodeLoginControllerClickCancel isEqualToString:code]) {
//                    [LDRHUD showHUDWithMessage:@"点击了授权页的返回"];
                } else if ([PNSCodeLoginControllerClickChangeBtn isEqualToString:code]) {
//                    [LDRHUD showHUDWithMessage:@"点击切换其他登录方式按钮"];
                    [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:NO complete:^{
                        [weakSelf presentPhoneNumberLogin];
                    }];
                    
                } else if ([PNSCodeLoginControllerClickLoginBtn isEqualToString:code]) {
                    if ([[resultDic objectForKey:@"isChecked"] boolValue] == YES) {
//                        [LDRHUD showHUDWithMessage:@"点击了登录按钮，check box选中，SDK内部接着会去获取登陆Token"];
                    } else {
//                        [LDRHUD showHUDWithMessage:@"点击了登录按钮，check box未选中，SDK内部不会去获取登陆Token"];
                    }
                } else if ([PNSCodeLoginControllerClickCheckBoxBtn isEqualToString:code]) {
//                    [LDRHUD showHUDWithMessage:@"点击check box"];
                } else if ([PNSCodeLoginControllerClickProtocol isEqualToString:code]) {
                    [LDRHUD showHUDWithMessage:@"点击了协议富文本"];
                } else if ([PNSCodeSuccess isEqualToString:code]) {
                    //点击登录按钮获取登录Token成功回调
                    NSString *token = [resultDic objectForKey:@"token"];
                    if (!token || token.length == 0) {
                        return;
                    }
                //下面拿Token去服务器换手机号，下面仅做参考
                    LDROneKeyLoginRequest *request = [LDROneKeyLoginRequest new];
                    request.aliAccessToken = token;
                    [LDRHUD showLoadingInView:nil];
                    [request asyncRequestWithsuccessHandler:^(BaseResponse *response) {
                        [LDRHUD hideHUD];
                        LDRLoginSuccessModel *model = response.data;
                        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        [user setObject:model.accessToken forKey:LDRSessionId];
                        [user setObject:@YES forKey:LDRLoginState];
                        [user synchronize];
                        [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:YES complete:nil];
                        [LDRHUD showHUDWithMessage:@"登录成功"];
                    } failHandler:^(BaseResponse *response) {
                        [LDRHUD hideHUD];
                        [LDRHUD showHUDWithMessage:@"登录失败，推荐您使用手机号码验证登录"];
                        [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:NO complete:^{
                            [weakSelf presentPhoneNumberLogin];
                        }];
                    }];
                } else {
                    [LDRHUD showHUDWithMessage:@"获取登录失败，推荐您使用手机号码验证登录"];
                    [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:NO complete:^{
                        [weakSelf presentPhoneNumberLogin];
                    }];
                }
            }];
        }
    }];
}

- (TXCustomModel *)getCustomModel
{
    TXCustomModel *model = [[TXCustomModel alloc] init]; //默认，注：model的构建需要放在主线程
    model.navColor = LDR_BackgroundColor;
    model.navBackImage = [UIImage imageNamed:@"login_back"];
    NSDictionary *attributes = @{
        NSFontAttributeName:LDRBoldFont17,
        NSForegroundColorAttributeName:LDR_TextBalckColor
    };
    [model setNavTitle:[[NSAttributedString alloc] initWithString:@"欢迎登录360租房" attributes:attributes]];
    model.logoImage = [UIImage imageNamed:@"login_logo_circular"];
    [model setLogoFrameBlock:^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        return CGRectMake(LDR_WIDTH / 2.0 - 40, 90, 80, 80);
    }];
    
    [model setNumberColor:LDR_TextBalckColor];
    [model setNumberFont:LDRBoldFont20];
    [model setNumberFrameBlock:^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        return CGRectMake(CGRectGetMinX(frame), 186, CGRectGetWidth(frame), 24);
    }];
    [model setSloganFrameBlock:^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        return CGRectMake(0, 219, LDR_WIDTH, 16);
    }];
    [model setLoginBtnText:[[NSAttributedString alloc] initWithString:@"同意协议并一键登录" attributes:@{
            NSFontAttributeName:LDRBoldFont14,
            NSForegroundColorAttributeName:LDR_BackgroundColor}]];
    [model setLoginBtnBgImgs:@[[UIImage imageNamed:@"button_background"],[UIImage ldr_imageWithColor:LDR_MainGreenGrayColor],[UIImage ldr_imageWithColor:LDR_GrayColor]]];
    [model setLoginBtnFrameBlock:^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        return CGRectMake(16, 259, LDR_WIDTH - 32, 48);
    }];
    
    [model setChangeBtnTitle:[[NSAttributedString alloc] initWithString:@"验证码登录" attributes:@{
            NSFontAttributeName:LDRBoldFont14,
            NSForegroundColorAttributeName:LDR_TextDarkGrayColor}]];
    [model setChangeBtnFrameBlock:^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        return CGRectMake(16, 327, LDR_WIDTH - 32, 48);
    }];

    [model setCheckBoxIsHidden:YES];
    [model setPrivacyOne:@[@"《360租房用户使用协议》",@""]];
    [model setPrivacyTwo:@[@"《隐私政策》",@""]];
    [model setPrivacyPreText:@"登录注册代表同意"];
    [model setPrivacyColors:@[LDR_TextGrayColor,LDR_MainGreenColor]];
    [model setPrivacyAlignment:NSTextAlignmentCenter];
    [model setPrivacyOperatorPreText:@"《"];
    [model setPrivacyOperatorSufText:@"》"];
    [model setPrivacyFont:LDRFont12];
    [model setPrivacyFrameBlock:^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        return CGRectMake(LDRPadding, 407, LDR_WIDTH - 32, 32);
    }];
    __block UIButton *wechatButton = [UIButton buttonWithTarget:self action:@selector(wechatButtonAction:)];
    wechatButton.frame = CGRectMake(LDR_WIDTH/ 2.0 - 48, LDR_HEIGHT - KNavBarAndStatusBarHeight - LDRPadding - 40 - KBottomSafeHeight, 40, 40);
    [wechatButton setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
    __block UIButton *appleButton = [UIButton buttonWithTarget:self action:@selector(appleButtonAction:)];
    appleButton.frame = CGRectMake(LDR_WIDTH/ 2.0 + 8, LDR_HEIGHT - KNavBarAndStatusBarHeight - LDRPadding - 40 - KBottomSafeHeight, 40, 40);
    [appleButton setImage:[UIImage imageNamed:@"login_apple"] forState:UIControlStateNormal];
    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
         [superCustomView addSubview:wechatButton];
        [superCustomView addSubview:appleButton];
    };
    return model;
}
@end
