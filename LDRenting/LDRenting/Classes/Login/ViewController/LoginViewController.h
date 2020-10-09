//
//  LoginViewController.h
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LDRLoginType) {
    LDRLoginTypeOneClick,
    LDRLoginTypePhoneNumber,
    LDRLoginTypeCode,
};

@interface LoginViewController : LDRBaseViewController
@property (nonatomic, assign) LDRLoginType loginType;
@property (nonatomic, copy) NSString *phoneNember;
@end

NS_ASSUME_NONNULL_END
