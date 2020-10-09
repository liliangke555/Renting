//
//  LDROrganizationRequest.m
//  LDRenting
//
//  Created by MAC on 2020/8/25.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDROrganizationRequest.h"

@implementation LDROrganizationRequest
- (NSString *)uri{
    return @"organization/ocr/v1/getData";
}
- (NSString *)requestMethod
{
    return @"POST";
}
- (Class)responseDataClass{
    return [LDROrganizationModel class];
}
@end

@implementation LDROrganizationModel

@end

@implementation LDROrganizationResultModel

@end

@implementation LDROrganizationAddressModel

@end

@implementation LDROrganizationLocationModel

@end
