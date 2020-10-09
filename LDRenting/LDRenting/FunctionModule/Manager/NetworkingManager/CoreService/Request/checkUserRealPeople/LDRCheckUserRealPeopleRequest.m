//
//  LDRCheckUserRealPeopleRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/25.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRCheckUserRealPeopleRequest.h"

@implementation LDRCheckUserRealPeopleRequest
- (NSString *)uri{
    return @"lock/realNameAuth/v1/checkUserRealPeople";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (Class)responseDataClass{
    return [LDRCheckRealModel class];
}
@end

@implementation LDRCheckRealModel



@end
