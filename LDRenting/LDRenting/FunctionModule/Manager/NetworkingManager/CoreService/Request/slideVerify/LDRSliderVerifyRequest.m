//
//  LDRSliderVerifyRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/18.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSliderVerifyRequest.h"

@implementation LDRSliderVerifyRequest
- (NSString *)uri{
    return @"lock/cAppLogin/v1/slideVerify";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (BOOL)isRequestParametersMethodJson
{
    return YES;
}
//- (Class)responseDataClass{
//    return [LDRAllRentHouseModel class];
//}
@end
