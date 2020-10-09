//
//  LDRWatchingHouseTableCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LDRWatchingHouseType) {
    LDRWatchingHouseNormal,
    LDRWatchingHouseAgree,
    LDRWatchingHouseRefuse,
};
@interface LDRWatchingHouseTableCell : LDRBaseTableViewCell
@property (nonatomic) LDRWatchingHouseType noticeType;
@end

NS_ASSUME_NONNULL_END
