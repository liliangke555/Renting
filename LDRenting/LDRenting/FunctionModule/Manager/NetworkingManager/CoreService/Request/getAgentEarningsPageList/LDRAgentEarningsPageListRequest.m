//
//  LDRAgentEarningsPageListRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAgentEarningsPageListRequest.h"

@implementation LDRAgentEarningsPageListRequest
- (NSString *)uri{
    return @"lock/channelStatement/v1/getAgentEarningsPageList";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (NSInteger)size
{
    return LDRRequestSize;
}
- (Class)responseDataClass{
    return [LDRMyProfitList class];
}

@end

@implementation LDRMyProfitList

- (NSString *)getArrayObjectClassNameForArrayName:(NSString *)arrayName{
    return @"LDRMyProfit";
}
@end

@implementation LDRMyProfit


@end
