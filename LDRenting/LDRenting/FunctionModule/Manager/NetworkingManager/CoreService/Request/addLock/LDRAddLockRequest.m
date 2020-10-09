//
//  LDRAddLockRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/24.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAddLockRequest.h"

@implementation LDRAddLockRequest
- (NSString *)uri{
    return @"lock/lockInfo/v1/add";
}
- (NSString *)requestMethod
{
    return @"POST";
}
@end
