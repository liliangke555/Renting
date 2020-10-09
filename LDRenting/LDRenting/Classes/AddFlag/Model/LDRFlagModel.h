//
//  LDRFlagModel.h
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRFlagModel : NSObject
@property (copy, nonatomic) NSString * title;
@property (assign, nonatomic,getter=isSelected) BOOL selected;

+ (instancetype)modelWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
