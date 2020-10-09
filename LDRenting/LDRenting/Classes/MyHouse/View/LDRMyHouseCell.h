//
//  LDRMyHouseCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/28.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRShadowTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRMyHouseCell : LDRShadowTableViewCell

@property (nonatomic, copy) void(^didClickAddHouse)(void);
@property (nonatomic, copy) void(^didClickAddBooking)(void);
@end

NS_ASSUME_NONNULL_END
