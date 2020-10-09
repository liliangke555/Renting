//
//  LDRAllRentHouseRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAllRentHouseRequest.h"

@implementation LDRAllRentHouseRequest
- (NSString *)uri{
    return @"lock/rentedHouse/v1/getAllRentHouse";
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
    return [LDRAllRentHouseModel class];
}
@end
