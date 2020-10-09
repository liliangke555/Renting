//
//  LDRMapAddressTableCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/20.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRMapAddressTableCell : LDRBaseTableViewCell
@property (nonatomic, copy) NSString *addessString;
@property (nonatomic) CGFloat distance;
@property (nonatomic, copy) NSString *road;
@end

NS_ASSUME_NONNULL_END
