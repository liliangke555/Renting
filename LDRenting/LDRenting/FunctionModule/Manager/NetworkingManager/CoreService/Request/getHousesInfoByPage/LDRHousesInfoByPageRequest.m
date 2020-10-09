//
//  LDRHousesInfoByPageRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHousesInfoByPageRequest.h"
@implementation LDRHousesInfoByPageRequest
- (NSString *)uri{
    return @"lock/houseInfo/v1/getHousesInfoByPage";
}
- (NSString *)requestMethod
{
    return @"POST";
}
//- (Class)responseDataClass{
//    return [LDRHouseInfosModel class];
//}
@end
