//
//  LDRCashbookInfoCountRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCashbookInfoCountRequest.h"
#import "LDRMybillModel.h"
@implementation LDRCashbookInfoCountRequest
- (NSString *)uri{
    return @"lock/cashbook/v1/getCashbookInfoCount";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (Class)responseDataClass{
    return [LDRMybillModel class];
}
@end