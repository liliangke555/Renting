//
//  NSObject+AutoCoding.m
//
//  实现NSDictionary自动填充到类对象里
// 
//  使用方法:
//  YouClass *obj = [YouClass objectWithDictionaryRepresentation:dictionary];
//
//  注意事项(针对需要自动填充的类):
//  1. 类中的成员必须定义成属性
//  2. 类中成员的类型必须是对应Json的几种类, NSNull, NSNumber, NSString, NSArray(或者对应的Mutable版本)
//  3. 如果类中含有数组类型的成员, 必须重载getArrayObjectClassNameForArrayName函数, 返回对应数组里的对象类型(ps. 数组里的元素必须一样才可以解析)
//  4. 继承的属性无法自动填充.需要手动添加一些特殊例外处理
//  Created by vincent on 12-12-14.
//  Copyright (c) 2012年 vincent. All rights reserved.
//

/**  
 json与objective-c的类型对应关系
 ---------------+------------------
 json           |  objective-c
 ---------------+------------------
 null           |   NSNull
 true and false	|   NSNumber
 Number         |   NSNumber
 String         |   NSString
 Array          |   NSArray
 Object         |   NSDictionary
 ---------------+-------------------
 */

#import "NSObject+AutoCoding.h"
#import <objc/runtime.h>

// 支持自动赋值的属性类型
typedef enum {
    NSNULL_TYPE,                // NSNULL
    NSNUMBER_TYPE,              // 数字
    NSMUTABLESTRING_TYPE,       // 可变字符串
    NSSTRING_TYPE,              // 不可变字符串
    NSARRAY_TYPE,               // 数组类型
    NSMUTABLEARRAY_TYPE,        // NSMUTALEARRAY
    NSOBJECT_CUSTOM_TYPE,       // 自定义的NSOBJECT类型
    UNSUPPORT_TYPE              // 无法自动转换的类型
} PROPERTY_TYPE;

// 获取属性的类型字符串
static const char * getPropertyTypeString(objc_property_t property)
{
    const char *attributes = property_getAttributes(property);
    //printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            NSInteger len = strlen(attribute) - 1;
            char *returnBuffer = malloc(len + 1);
            memset(returnBuffer, 0, len+1);
            strncpy(returnBuffer, attribute + 1, len);
            return returnBuffer;
            //            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:、
            char *returnBuffer = malloc(3);
            memset(returnBuffer, 0, 3);
            strncpy(returnBuffer, "id", 2);
            return returnBuffer;
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            NSInteger len = strlen(attribute) - 4;
            char *returnBuffer = malloc(len + 1);
            memset(returnBuffer, 0, len+1);
            strncpy(returnBuffer, attribute + 3, len);
            return returnBuffer;
            //            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    char *returnBuffer = malloc(1);
    memset(returnBuffer, 0, 1);
    return returnBuffer;
}

// 对属性类型字符串进行分类
static PROPERTY_TYPE property_getType(const char *type_string)
{
    if (!(strcmp(type_string, "NSNull")))
    {
        return NSNULL_TYPE;
    }
    else if (!(strcmp(type_string, "NSNumber")))
    {
        return NSNUMBER_TYPE;
    }
    else if (!(strcmp(type_string, "NSArray")))
    {
        return NSARRAY_TYPE;
    }
    else if (!(strcmp(type_string, "NSMutableArray")))
    {
        return NSMUTABLEARRAY_TYPE;
    }
    else if (!(strcmp(type_string, "NSString")))
    {
        return NSSTRING_TYPE;
    }
    else if (!(strcmp(type_string, "NSMutableString")))
    {
        return NSMUTABLESTRING_TYPE;
    }
    else if (strlen(type_string)==1)
    {
        return UNSUPPORT_TYPE;
    }
    else
    {
        return NSOBJECT_CUSTOM_TYPE;
    }
    
}

@implementation NSObject (AutoMagicCoding)

#pragma mark Decode/Create/Init

// 根据字典生成对象实例
+ (id) objectWithDictionaryRepresentation: (NSDictionary *) aDict
{
    if (![aDict isKindOfClass:[NSDictionary class]])
        return [[self alloc] init];
    
    Class rClass = self.class;//NSClassFromString(className);
    if ( rClass && [rClass instancesRespondToSelector:@selector(initWithDictionaryRepresentation:)])
    {
        id instance = [[rClass alloc] initWithDictionaryRepresentation: aDict];
        return instance;
    }
    
    return nil;
}

// 根据字典初始化实例
- (id) initWithDictionaryRepresentation: (NSDictionary *)aDict
{
    self = [self init];
    if (![aDict isKindOfClass:[NSDictionary class]])
        return nil;
    // 获取属性列表
    //id Class = objc_getClass(self.class.name);
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    // 对每个属性获取属性类型，如果有数组，由于数组里的对象的类型未知，需要由类提供数组对象的类型名
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        id value;
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        
        const char *type_string = getPropertyTypeString(property);
        PROPERTY_TYPE type = property_getType(type_string);
        
        switch (type) {
                // 常规类型直接赋值
            case NSNULL_TYPE:
            case NSNUMBER_TYPE:
            case NSSTRING_TYPE:
            case NSMUTABLESTRING_TYPE:
                if([[aDict objectForKey:name] isKindOfClass:[NSNull class]])
                {
                    [self setValue:nil forKey:name];
                }
                else
                {
                    [self setValue:[aDict objectForKey:name] forKey:name];
                }
                break;
                // 数组的处理
            case NSARRAY_TYPE:
            case NSMUTABLEARRAY_TYPE:
                // 类中必须响应getArrayObjectClassNameForArrayName:方法
                if (![self respondsToSelector:@selector(getArrayObjectClassNameForArrayName:)])
                {
                    NSLog(@"Must reimplement getArrayObjectClassNameForArrayName!!!");
                    break;
                }
                value = [aDict objectForKey:name];
                if (value==nil)
                {
                    [self setValue:nil forKey:name];
                }
                else if (![value isKindOfClass:[NSArray class]])
                {
                    // 属性是数组,Dictionary中对应的也应该是数组,详见代码头的json与object-c对应类型关系
//                    NSLog(@"Property type don't match!!!Class property type is nsarray, json must be array too!");
                    [self setValue:nil forKey:name];
                }
                else
                {
                    // 临时数组，用来填充数据
                    NSMutableArray *targetArray = [[NSMutableArray alloc]init];
                    // 获取该属性数组的名称
                    Class arrayObjectClass = NSClassFromString([self getArrayObjectClassNameForArrayName:name]);
                    for (int i=0; i<[value count]; i++)
                    {
                        id objInDictionary = [value objectAtIndex:i];
                        id obj;
                        // 数组中的子对象是自定义的对象,继续填充子对象
                        if ([objInDictionary isKindOfClass:[NSDictionary class]])
                        {
                            obj = [arrayObjectClass objectWithDictionaryRepresentation:objInDictionary];
                        }
                        // 数组中的子对象是常规对象,如NSString, NSNumber等,直接填充子对象
                        else
                        {
                            obj = objInDictionary;
                        }
                        [targetArray addObject:obj];
                    }
                    if (type == NSMUTABLEARRAY_TYPE)
                    {
                        [self setValue:[targetArray mutableCopy] forKey:name];
                    }
                    else
                    {
                        [self setValue:[targetArray copy] forKey:name];
                    }
                    
                }
                break;
                // 成员是个复杂对象的处理
            case NSOBJECT_CUSTOM_TYPE:
                // json中的对象对应到NSDictionary中
                value = [aDict objectForKey:name];
                if (![value isKindOfClass:[NSDictionary class]])
                {
                    [self setValue:nil forKey:name];
                }
                else
                {
                    Class subObjectClass = [objc_getClass(type_string) class];
                    id subObject = [subObjectClass objectWithDictionaryRepresentation:value];
                    [self setValue:subObject forKey:name];
                }
                break;
            default:
                break;
        }
        free((void*)type_string);
    }
    free(properties);
    return self;
}


@end
