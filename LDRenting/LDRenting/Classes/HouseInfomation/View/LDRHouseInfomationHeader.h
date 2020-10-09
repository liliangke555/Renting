//
//  LDRHouseInfomationHeader.h
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRHouseInfomationHeader : LDRBaseHeaderView
- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                   leftAction:(void(^)(void))leftAction
                  rightAction:(void(^)(void))rightAction;
@end

NS_ASSUME_NONNULL_END
