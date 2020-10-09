//
//  LDRHouseConfigModel.m
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHouseConfigModel.h"

@implementation LDRHouseConfigModel

+ (instancetype)createModelWithTitle:(NSString *)title imageurl:(NSString *)imgeUrl
{
    LDRHouseConfigModel *model = [[LDRHouseConfigModel alloc] init];
    model.title = title;
    model.imageUrl = imgeUrl;
    return model;
}
@end
