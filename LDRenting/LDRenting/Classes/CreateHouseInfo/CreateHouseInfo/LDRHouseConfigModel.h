//
//  LDRHouseConfigModel.h
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRHouseConfigModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign,getter=isSelected) BOOL selected;

+ (instancetype)createModelWithTitle:(NSString *)title imageurl:(NSString *)imgeUrl;
@end

NS_ASSUME_NONNULL_END
