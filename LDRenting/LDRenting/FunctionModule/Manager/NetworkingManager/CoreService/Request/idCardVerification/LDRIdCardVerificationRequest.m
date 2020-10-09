//
//  LDRIdCardVerificationRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/25.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRIdCardVerificationRequest.h"

@implementation LDRIdCardVerificationRequest
- (NSString *)uri{
    return @"lock/tencentCloud/v1/idCardVerification";
}
- (NSString *)requestMethod
{
    return @"POST";
}
//- (Class)responseDataClass{
//    return [LDROrganizationModel class];
//}
@end
