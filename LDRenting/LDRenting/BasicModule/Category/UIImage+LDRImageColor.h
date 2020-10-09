//
//  UIImage+LDRImageColor.h
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LDRImageColor)

+ (UIImage *) ldr_imageWithColor:(UIColor *)color;

+ (UIImage *) ldr_imageWithColor:(UIColor *)color Size:(CGSize)size;

- (UIImage *) ldr_stretched;


/// 压缩图片
/// @param maxLength 200KB
- (NSData *)compressImageToByte:(NSInteger)maxLength;
@end

NS_ASSUME_NONNULL_END
