//
//  LDRRenantsInfoHeaderCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/30.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRRenantsInfoHeaderCell : LDRBaseTableViewCell
@property (nonatomic, copy) void(^didClickChange)(void);
@end

NS_ASSUME_NONNULL_END
