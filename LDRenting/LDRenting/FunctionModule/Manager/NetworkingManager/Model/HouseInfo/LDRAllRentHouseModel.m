//
//  LDRHouseInfosModel.m
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAllRentHouseModel.h"

@implementation LDRAllRentHouseModel
- (NSString *)getArrayObjectClassNameForArrayName:(NSString *)arrayName{
    return @"LDRRentHouseModel";
}
@end

@implementation LDRRentHouseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
     if([key isEqualToString:@"id"]){
         _uid = value;
     }
}

@end
