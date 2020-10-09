//
//  LDRRenantsFlagTableCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRRenantsFlagTableCell : LDRBaseTableViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) void(^didClickAddFlag)(void);
@end

NS_ASSUME_NONNULL_END
