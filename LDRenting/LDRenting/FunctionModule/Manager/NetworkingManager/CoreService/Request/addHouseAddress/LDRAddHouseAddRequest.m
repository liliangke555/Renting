//
//  LDRAddHouseAddRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/20.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddHouseAddRequest.h"

@implementation LDRAddHouseAddRequest
- (NSString *)uri{
    return @"lock/houseInfo/v1/add";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (NSInteger)houseType
{
    return 1;
}
- (Class)responseDataClass{
    return [LDRAddHouseModel class];
}
@end

@implementation LDRAddHouseModel

@end
