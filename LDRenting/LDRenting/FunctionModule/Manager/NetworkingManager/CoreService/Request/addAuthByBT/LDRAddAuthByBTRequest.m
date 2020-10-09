//
//  LDRAddAuthByBTRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/25.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddAuthByBTRequest.h"

@implementation LDRAddAuthByBTRequest
- (NSString *)uri{
    return @"lock/userOpenType/v1/addAuthByBT";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (Class)responseDataClass{
    return [LDRAddAuthByBTModel class];
}
@end

@implementation LDRAddAuthByBTModel

@end
