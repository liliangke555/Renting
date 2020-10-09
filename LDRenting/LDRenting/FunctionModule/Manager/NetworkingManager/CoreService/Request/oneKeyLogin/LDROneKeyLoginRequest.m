//
//  LDROneKeyLoginRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDROneKeyLoginRequest.h"
@implementation LDROneKeyLoginRequest
- (NSString *)uri{
    return @"lock/cAppLogin/v1/oneKeyLogin";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (BOOL)isRequestParametersMethodJson
{
    return YES;
}
- (NSString *)loginSource
{
    return @"rent_ios_app";
}
- (Class)responseDataClass{
    return [LDRLoginSuccessModel class];
}
@end
