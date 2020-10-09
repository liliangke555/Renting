//
//  LDRCashnookIndexCount.m
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCashnookIndexCountRequest.h"
#import "LDRCashbookIndexCountModel.h"

@implementation LDRCashnookIndexCountRequest
- (NSString *)uri{
    return @"lock/cashbook/v1/getCashbookIndexCount";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (Class)responseDataClass{
    return [LDRCashbookIndexCountModel class];
}
@end
