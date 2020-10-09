//
//  LDRRefreshTokenRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/18.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRRefreshTokenRequest.h"
#import "LDRPhoneCodeLoginRequest.h"

@implementation LDRRefreshTokenRequest
- (NSString *)uri{
    return @"auth/token/v1/get";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (BOOL)isRequestParametersMethodJson
{
    return YES;
}
- (NSString *)grantType
{
    return @"refresh_token";
}
- (Class)responseDataClass{
    return [LDRLoginSuccessModel class];
}
@end
