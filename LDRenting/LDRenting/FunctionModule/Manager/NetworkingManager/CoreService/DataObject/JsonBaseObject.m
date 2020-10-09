//
//  JsonBaseObject.m
//  HaiXing
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "JsonBaseObject.h"
#import <objc/runtime.h>


@implementation JsonBaseObject

- (NSString *)description
{
    return [self getJsonString];
}

- (NSData *)getJsonData
{
    return [NSJSONSerialization dataWithJSONObject:[self getJsonDictionary] options:NSJSONWritingPrettyPrinted error:nil];
}

- (NSString *)getJsonString
{
    return [[NSString alloc] initWithData:[self getJsonData] encoding:NSUTF8StringEncoding];
}

- (NSMutableDictionary *)getJsonDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    //获取属性列表
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        id value = [self valueForKey:name];
        if(value == nil)
        {
            continue;
        }
        value = [self getObjectInternal:value];
        [dic setObject:value forKey:name];
    }
    free(properties);
    
    return dic;
}
//递归获取属性对应的值
- (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [obj getJsonDictionary];
}


#pragma mark - NSCoding 用来实现归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //    [super encodeWithCoder:aCoder];
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    // 对每个属性获取属性类型，如果有数组，由于数组里的对象的类型未知，需要由类提供数组对象的类型名
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        id value = [self valueForKey:name];
        // 数据成员必须都是object的
        [aCoder encodeObject:value forKey:name];
    }
    free(properties);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        unsigned int outCount, i;
        
        objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
        // 对每个属性获取属性类型，如果有数组，由于数组里的对象的类型未知，需要由类提供数组对象的类型名
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *name = [NSString stringWithUTF8String:property_getName(property)];
            id value = [aDecoder decodeObjectForKey:name];
            [self setValue:value forKey:name];
        }
        free(properties);
    }
    return self;
}

@end
