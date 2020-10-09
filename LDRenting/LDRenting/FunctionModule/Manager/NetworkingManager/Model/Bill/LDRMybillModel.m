//
//  LDRMybillModel.m
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMybillModel.h"

@implementation LDRMybillModel
- (NSString *)getArrayObjectClassNameForArrayName:(NSString *)arrayName{
    return @"LDRMybillDetailModel";
}

@end

@implementation LDRMybillDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
     if([key isEqualToString:@"id"]){
         _uid = value;
     }
}

@end
