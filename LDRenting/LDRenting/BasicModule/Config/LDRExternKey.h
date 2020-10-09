//
//  LDRExternKey.h
//  LDRenting
//
//  Created by MAC on 2020/7/15.
//  Copyright © 2020 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LDROffLineOpenType) {
    LDROffLineOpenTypeFinger,
    LDROffLineOpenTypeICCard,
    LDROffLineOpenTypePassword,
};

typedef NS_ENUM(NSUInteger, LDRFlagType) {
    LDRFlagTypeGood,
    LDRFlagTypeWarning,
    LDRFlagTypePoor,
};

typedef NS_ENUM(NSUInteger, LDROpenType) {
    LDROpenTypeFinger = 1,
    LDROpenTypeICCard = 2,
    LDROpenTypeLocPassword = 5,
};
//-- APP KEY
extern NSString * const ServerAddressWeb;
extern NSString *const LDRAliInfo; //阿里 一键登录 key
extern NSString *const LDRAliSliderURL; //滑块验证 URL
extern NSString *const LDRAliSliderKey; //滑块验证 key
extern NSString *const LDRAliSliderScene; // 滑块验证 scene
extern NSString *const LDRAliSliderCallBackName; // 滑块验证 回调方法名

extern NSString *const LDRSessionId; //
extern NSString *const LDRRefresSessionId; //

extern NSInteger const LDRRequestSize; // 接口获取一页的条目

//-- 通知 key
extern NSString *const LDRWechatLoginSuccess;

//-- 状态 KEY
extern NSString *const LDRLoginState;
extern NSString *const LDRAddHouseRemindState;
extern NSString *const LDRMineRemindState;
extern NSString *const LDRAddRentingRemindState;
extern NSString *const LDRBuleToothConnected;

//-- UI
extern CGFloat const LDRPadding;
extern CGFloat const LDRRadius;
extern CGFloat const LDRControllerRadius;
extern CGFloat const LDRShadowRadius;
extern CGFloat const LDRShadowBottomRaius;
extern CGFloat const LDRHomeHeaderHeight;
extern CGFloat const LDRButtonHeight;
//-- 文字
extern NSString *const LDRAlterCancle;
extern NSString *const LDRAlterYes;
extern NSString *const LDRAlterGoTo;
extern NSString *const LDRAlterTitleMiniPragma;
extern NSString *const LDRAlterDetailsMiniPragma;
extern NSString *const LDRButtonBuyNow;
extern NSString *const LDRButtonAddNow;
extern NSString *const LDRButtonHaveAddNow;
extern NSString *const LDRButtonNextStep;

extern NSString *const LDRLoginOrRegist;
extern NSString *const LDRHomeMyWallet;
extern NSString *const LDRHomeHousingTrends;
extern NSString *const LDRHomeNoservice;
extern NSString *const LDRAddLockViewTitle;
extern NSString *const LDRAddLockSetpOne;
extern NSString *const LDRAddLockSetpOneDetails;
extern NSString *const LDRAddLockSetpTwo;
extern NSString *const LDRAddLockSetpTwoDetails;
extern NSString *const LDRAddLockSetpNote;
extern NSString *const LDRAddLockSetpCompletion;


//-- 图片 icon key
extern NSString *const LDRLoginBackIcon;
extern NSString *const LDRNoLoginHeader;
extern NSString *const LDRNoLoginMessageIconOne;
extern NSString *const LDRNoLoginMessageIconTwo;
extern NSString *const LDRNoLoginMessageNoSever;


NS_ASSUME_NONNULL_END
