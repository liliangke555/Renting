//
//  LDRSelectHouseController.h
//  LDRenting
//
//  Created by MAC on 2020/7/30.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewController.h"


@class LDRRentHouseModel;
NS_ASSUME_NONNULL_BEGIN

@interface LDRSelectHouseController : LDRBaseTableViewController
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) void(^didSelectedHouse)(LDRRentHouseModel *model);
@end

NS_ASSUME_NONNULL_END
