//
//  NSObject+AutoCoding.h
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
//  4. 继承的属性无法自动填充.
//  Created by vincent on 12-12-14.
//  Copyright (c) 2012年 AVIT. All rights reserved.
//

/**
 json与objective-c的类型对应关系
 ---------------+-------------------
 json           |  objective-c
 ---------------+-------------------
 null           |   NSNull
 true and false	|   NSNumber
 Number         |   NSNumber
 String         |   NSString
 Array          |   NSArray
 Object         |   NSDictionary
 ---------------+-------------------
 */

#import <Foundation/Foundation.h>

@interface NSObject(AutoCoding)

/** Creates autoreleased object with given dictionary representation.
 * Returns nil, if aDict is nil or there's no class in your programm with name
 * provided in dict for key kAMCDictionaryKeyClassName.
 *
 * ATTENTION: Can throw exceptions - see README.md "Exceptions" part for details.
 * Define AMC_NO_THROW to disable throwing exceptions by this method and make
 * it return nil instead.
 *
 * @param aDict Dictionary that contains name of class NSString for
 * kAMCDictionaryKeyClassName key & all other values for keys in the saved object.
 */
+ (id) objectWithDictionaryRepresentation: (NSDictionary *) aDict;

/** Designated initializer for AMC. Treat it as something like -initWithCoder:
 * Inits object with key values from given dictionary.
 * Doesn't test objectForKey: kAMCDictionaryKeyClassName in aDict to be equal
 * with [self className].
 *
 * ATTENTION: Can throw exceptions - see README.md "Exceptions" part for details.
 * Define AMC_NO_THROW to disable throwing exceptions by this method and make
 * it return nil instead.
 *
 * @param aDict Dictionary that contains key and value
 */
- (id) initWithDictionaryRepresentation: (NSDictionary *) aDict;

// 针对所有的数组成员名返回对应的数组里的对象的类型名
- (NSString *) getArrayObjectClassNameForArrayName : (NSString *)arrayName;

@end
