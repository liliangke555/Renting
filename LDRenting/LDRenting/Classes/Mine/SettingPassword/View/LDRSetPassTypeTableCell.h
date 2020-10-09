//
//  LDRSetPassTypeTableCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRSetPassTypeTableCell : LDRBaseTableViewCell
@property (nonatomic, assign,getter=isSetPassNum) BOOL setPassNum;
@property (nonatomic, assign) NSInteger passType;
@property (nonatomic, copy) void(^didChangeType)(NSInteger passType);
@end

NS_ASSUME_NONNULL_END
