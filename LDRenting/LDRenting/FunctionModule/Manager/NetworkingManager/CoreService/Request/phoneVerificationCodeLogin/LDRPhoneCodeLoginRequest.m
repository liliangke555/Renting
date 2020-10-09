//
//  LDRPhoneCodeLoginRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/18.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRPhoneCodeLoginRequest.h"

@implementation LDRPhoneCodeLoginRequest
- (NSString *)uri{
    return @"lock/cAppLogin/v1/phoneVerificationCodeLogin";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (Class)responseDataClass{
    return [LDRLoginSuccessModel class];
}
- (BOOL)isRequestParametersMethodJson
{
    return YES;
}
- (NSString *)loginSource
{
    return @"rent_ios_app";
}
@end

@implementation LDRLoginSuccessModel
@end
