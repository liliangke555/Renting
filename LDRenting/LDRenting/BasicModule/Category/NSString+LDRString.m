//
//  NSString+LDRString.m
//  LDRenting
//
//  Created by MAC on 2020/7/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "NSString+LDRString.h"

@implementation NSString (LDRString)

/// 设置富文本
- (NSMutableAttributedString *)getPriceAttribute
{
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:self];
    //目的是想改变 ‘/’前面的字体的属性，所以找到目标的range
    NSMutableString *muStr = [NSMutableString stringWithString:self];
    NSRange range = [muStr rangeOfString:@"《"];
    if (range.location != NSNotFound) {
        [attribut addAttributes:@{NSForegroundColorAttributeName:LDR_TextDarkGrayColor} range:NSMakeRange(0, range.location)];
    }
    NSRange pointRange = [muStr rangeOfString:@"、"];
    if (pointRange.location != NSNotFound) {
        [attribut addAttributes:@{NSForegroundColorAttributeName:LDR_TextDarkGrayColor} range:pointRange];
    }
    while ([muStr containsString:@"《"]) {
        NSRange range = [muStr rangeOfString:@"《"];
        NSRange endRange = [muStr rangeOfString:@"》"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = endRange.location - range.location;
            NSRange pointRange = NSMakeRange(loc, len + 1);
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[NSForegroundColorAttributeName] = LDR_MainGreenColor;
            //赋值
            [attribut addAttributes:dic range:pointRange];
            [muStr replaceCharactersInRange:range withString:@" "];
            [muStr replaceCharactersInRange:endRange withString:@" "];
        }
    }
    return attribut;
}

- (NSMutableAttributedString *)getMainColorAttributeWithString:(NSString *)string
{
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:string];
    if (range.location != NSNotFound) {
        [attribut addAttributes:@{NSForegroundColorAttributeName:LDR_MainGreenColor} range:range];
    }
    return attribut;
}

/**
 验证手机号码

 @return 正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isMobileNumber {// @"^(13[0-9]|14[56789]|15[0-9]|16[6]|17[0-9]|18[0-9]|19[189])\\d{8}$";
    NSString *emailRegex = @"^1(3[0-9]|4[56789]|5[0-9]|6[6]|7[0-9]|8[0-9]|9[189])\\d{8}$";
    return [self isValidateByRegex:emailRegex];
}
/**
 基础方法

 @param regex 正则表达式
 @return 正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidateByRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}
- (NSString *)removeSpaceAndNewline
{
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        return temp;
}
/// Hex编码
/// @param data data
+ (NSString *)stringFromData:(NSData *)data
{
    Byte *bytes = (Byte *)[data bytes];
    NSString *string = @"";
    for (NSInteger i = 0; i<data.length; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xff]; //16进制数
        newHexStr = [newHexStr uppercaseString];
        if ([newHexStr length] == 1) {
            newHexStr = [NSString stringWithFormat:@"0%@",newHexStr];
        }
        string = [string stringByAppendingString:newHexStr];
    }
    return string;
}
+ (NSData *)dataFromString:(NSString *)str
{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

+ (NSInteger)numberWithHexString:(NSString *)hexString
{

    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}
// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString
{
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

/// string 转 data
- (NSData *)hexToBytes
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
@end
