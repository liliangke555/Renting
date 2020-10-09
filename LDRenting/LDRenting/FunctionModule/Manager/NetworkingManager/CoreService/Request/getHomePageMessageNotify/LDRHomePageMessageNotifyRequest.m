//
//  LDRHomePageMessageNotifyRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomePageMessageNotifyRequest.h"

@implementation LDRHomePageMessageNotifyRequest
- (NSString *)uri{
    return @"lock/messageNotify/v1/getHomePageMessageNotify";
}
- (NSString *)requestMethod
{
    return @"GET";
}
- (Class)responseDataClass{
    return [LDRHomeMessageModel class];
}
@end

@implementation LDRHomeMessageModel


@end
