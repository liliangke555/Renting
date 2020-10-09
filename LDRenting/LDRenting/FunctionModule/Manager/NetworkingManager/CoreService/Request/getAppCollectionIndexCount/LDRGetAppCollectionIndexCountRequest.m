//
//  LDRGetAppCollectionIndexCountRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRGetAppCollectionIndexCountRequest.h"
#import "LDRCollectionIndexCountModel.h"
@implementation LDRGetAppCollectionIndexCountRequest
- (NSString *)uri{
    return @"lock/cashbook/v1/getAppCollectionIndexCount";
}
- (NSString *)requestMethod
{
    return @"GET";
}
- (Class)responseDataClass{
    return [LDRCollectionIndexCountModel class];
}
@end
