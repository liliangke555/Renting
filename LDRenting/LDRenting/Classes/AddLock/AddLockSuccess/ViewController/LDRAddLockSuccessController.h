//
//  LDRAddLockSuccessController.h
//  LDRenting
//
//  Created by MAC on 2020/7/23.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRAddLockSuccessController : LDRBaseTableViewController
@property (nonatomic, copy) NSString *houseName; //!< 房屋名字
@property (nonatomic, copy) NSString *macString; //!< 门锁mac
@property (nonatomic, copy) NSString *userHouseRelationId; //!< 用户房屋关联id
@end

NS_ASSUME_NONNULL_END
