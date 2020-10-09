//
//  NSString+LDRString.h
//  LDRenting
//
//  Created by MAC on 2020/7/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LDRString)

- (NSMutableAttributedString *)getPriceAttribute;
- (NSMutableAttributedString *)getMainColorAttributeWithString:(NSString *)string;

/// 验证手机号
- (BOOL)isMobileNumber;

/// 去除 字符中的 空格和换行
- (NSString *)removeSpaceAndNewline;

/// Hex编码
/// @param data data
+ (NSString *)stringFromData:(NSData *)data;
+ (NSData *)dataFromString:(NSString *)string;
/// 16进制字符串转 int
/// @param hexString 16进制字符
+ (NSInteger)numberWithHexString:(NSString *)hexString;
+ (NSString *)stringFromHexString:(NSString *)hexString;
- (NSData *)hexToBytes;

@end

NS_ASSUME_NONNULL_END
