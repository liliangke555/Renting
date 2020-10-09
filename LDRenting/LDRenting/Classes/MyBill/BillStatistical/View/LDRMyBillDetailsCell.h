//
//  LDRMyBillDetailsCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/27.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LDRBillCellType) {
    LDRBillCellMyBill,
    LDRBillCellRentRecords,
};

@interface LDRMyBillDetailsCell : LDRBaseTableViewCell

@property (nonatomic, assign) BOOL income;
@property (nonatomic, copy) NSString *house;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, assign) LDRBillCellType cellType;

@end

NS_ASSUME_NONNULL_END
