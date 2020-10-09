//
//  LDRLockPassManageTableCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRShadowTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRLockPassManageTableCell : LDRShadowTableViewCell
@property (nonatomic, assign,getter=isOverstayed) BOOL overstayed;
@property (nonatomic, copy) void(^didClickCheck)(void);
@property (nonatomic, copy) void(^didClickDelete)(void);
@end

NS_ASSUME_NONNULL_END
