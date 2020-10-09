//
//  LDRExternKey.m
//  LDRenting
//
//  Created by MAC on 2020/7/15.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRExternKey.h"

NSString * const ServerAddressWeb = @"https://tc.lookdoor.cn:1999";
NSString * const LDRAliSliderURL = @"https://tc.lookdoor.cn:1999/statics/mini-rent-house/h5/dist/nch5.html"; //滑块验证 URL

NSString *const LDRAliInfo = @"62xRq0cckDgqY4o8nlNiydSkOfsIyy+An2lSnI6LzxStwBs8g2Rqe2W4tzDbIIHtfn05ZRYOVSb04myvDAYNRC2kRKebFWL+OnNpeVf/Z+UJdDgusCjRGhkiz/wQ4KMxHOug98rlA/vVzA0YiLJj+O2FDXVGJT7d7/lHDf/CIAv8ixavqrM5JN+kxweKgRBK5jmkvkVdCDT0vUHZeSOOXFP7O6anhr1cv+CTPPJmVPgGHjfD3qQZjA==";

NSString *const LDRAliSliderKey = @"FFFF0N00000000005BB4"; //滑块验证 key
NSString *const LDRAliSliderScene = @"nc_login_h5"; // 滑块验证 scene
NSString *const LDRAliSliderCallBackName = @"successCallback"; // 滑块验证 回调方法名

NSString *const LDRSessionId = @"Authorization"; //
NSString *const LDRRefresSessionId = @"accessTokenRefresh";

NSString *const LDRLoginState = @"LDRLoginState";
NSString *const LDRAddHouseRemindState = @"LDRAddHouseRemindState";
NSString *const LDRMineRemindState = @"LDRMineRemindState";
NSString *const LDRAddRentingRemindState = @"LDRAddRentingRemindState";

NSString *const LDRWechatLoginSuccess = @"LDRWechatLoginSuccess";
NSString *const LDRBuleToothConnected = @"LDRBuleToothConnected";

NSInteger const LDRRequestSize = 20; // 接口获取一页的条目

CGFloat const LDRPadding = 16.0f;
CGFloat const LDRRadius = 6.0f;
CGFloat const LDRControllerRadius = 12.0f;
CGFloat const LDRShadowRadius = 4.0f;
CGFloat const LDRShadowBottomRaius = 64.0f;
CGFloat const LDRHomeHeaderHeight = 176.0f;
CGFloat const LDRButtonHeight = 48.0f;

NSString *const LDRAlterCancle = @"取消";
NSString *const LDRAlterYes = @"确定";
NSString *const LDRAlterGoTo = @"前往";
NSString *const LDRAlterTitleMiniPragma = @"小程序打开确认";
NSString *const LDRAlterDetailsMiniPragma = @"即将跳往“360租房小程序”，确定打开？";
NSString *const LDRButtonBuyNow = @"立即购买";
NSString *const LDRButtonHaveAddNow = @"已有，立即添加";
NSString *const LDRButtonAddNow = @"立即添加";
NSString *const LDRButtonNextStep = @"下一步";

NSString *const LDRLoginOrRegist = @"请先登录/注册";
NSString *const LDRHomeMyWallet = @"我的收租钱包";
NSString *const LDRHomeHousingTrends = @"房屋动态";
NSString *const LDRHomeNoservice = @"当前城市暂未开通该服务";

NSString *const LDRAddLockViewTitle = @"添加门锁";
NSString *const LDRAddLockSetpOne = @"步骤1";
NSString *const LDRAddLockSetpOneDetails = @"打开手机蓝牙开关，安卓手机用户请打开\n“位置信息或GPS”";
NSString *const LDRAddLockSetpTwo = @"步骤2";
NSString *const LDRAddLockSetpTwoDetails = @"打开后盖，按下右上角的“设置”按钮，待语音播报\n完成后按下门锁数字键盘上的【4】+【#】键";
NSString *const LDRAddLockSetpNote = @"注：若配对时长超过3分钟，重新尝试步骤2";
NSString *const LDRAddLockSetpCompletion = @"   我已完成以上操作";

NSString *const LDRLoginBackIcon = @"login_background";
NSString *const LDRNoLoginHeader = @"no_login_header";
NSString *const LDRNoLoginMessageIconOne = @"home_message_one";
NSString *const LDRNoLoginMessageIconTwo = @"home_message_two";
NSString *const LDRNoLoginMessageNoSever = @"home_message_no";
