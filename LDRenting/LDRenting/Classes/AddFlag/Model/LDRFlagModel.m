//
//  LDRFlagModel.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRFlagModel.h"

@implementation LDRFlagModel
+ (instancetype)modelWithTitle:(NSString *)title
{
    LDRFlagModel *model = [[LDRFlagModel alloc] init];
    model.title = title;
    return model;
}
@end
