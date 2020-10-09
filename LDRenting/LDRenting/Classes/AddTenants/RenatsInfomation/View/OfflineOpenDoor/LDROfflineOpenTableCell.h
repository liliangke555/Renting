//
//  LDROfflineOpenTableCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDROfflineOpenTableCell : LDRBaseTableViewCell

@property (nonatomic, copy) void(^didClickFinger)(void);
@property (nonatomic, copy) void(^didClickicCard)(void);

@end

NS_ASSUME_NONNULL_END
