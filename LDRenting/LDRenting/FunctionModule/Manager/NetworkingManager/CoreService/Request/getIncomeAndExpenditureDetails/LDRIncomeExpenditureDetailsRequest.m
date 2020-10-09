//
//  LDRIncomeExpenditureDetailsRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRIncomeExpenditureDetailsRequest.h"

@implementation LDRIncomeExpenditureDetailsRequest
- (NSString *)uri{
    return @"lock/cashbook/v1/getIncomeAndExpenditureDetails";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (Class)responseDataClass{
    return [LDRMybillModel class];
}
@end
