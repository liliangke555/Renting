//
//  LDRCreateHousePhotoTableCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRCreateHousePhotoTableCell : LDRBaseTableViewCell
@property (strong, nonatomic) NSMutableArray * dataSource;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *detailString;
@property (nonatomic, copy) void(^didReliadTableView)(void);
@end

NS_ASSUME_NONNULL_END
